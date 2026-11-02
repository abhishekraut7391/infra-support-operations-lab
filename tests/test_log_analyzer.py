import tempfile
import unittest
from collections import Counter
from pathlib import Path
import subprocess
import sys

from scripts.log_analyzer import analyze_lines, build_report

PROJECT_ROOT = Path(__file__).resolve().parents[1]
ANALYZER = PROJECT_ROOT / "scripts" / "log_analyzer.py"
SAMPLE_LOG = PROJECT_ROOT / "sample_logs" / "sample_system.log"


class LogAnalyzerTests(unittest.TestCase):
    def test_classifies_severity(self):
        counts, matches = analyze_lines([
            "INFO service ready",
            "WARNING high latency",
            "ERROR request failed",
            "CRITICAL worker stopped",
        ])
        self.assertEqual(counts, Counter({"WARNING": 1, "ERROR": 1, "CRITICAL": 1}))
        self.assertEqual(len(matches), 3)

    def test_critical_takes_precedence(self):
        counts, matches = analyze_lines(["CRITICAL failure caused an error"])
        self.assertEqual(counts["CRITICAL"], 1)
        self.assertEqual(counts["ERROR"], 0)
        self.assertEqual(matches[0][1], "CRITICAL")

    def test_report_when_nothing_matches(self):
        report = build_report(Path("empty.log"), Counter(), [])
        self.assertIn("Matching lines: 0", report)
        self.assertIn("No matching severity keywords", report)

    def test_summarizes_lines(self):
        counts, matches = analyze_lines(["INFO ok", "WARN slow", "fatal crash"])
        report = build_report(Path("sample.log"), counts, matches)
        self.assertIn("WARNING:  1", report)
        self.assertIn("CRITICAL: 1", report)
        self.assertIn("line    3 [CRITICAL]", report)

    def test_sample_log_counts(self):
        with SAMPLE_LOG.open(encoding="utf-8") as handle:
            counts, matches = analyze_lines(handle)
        self.assertEqual(counts["CRITICAL"], 1)
        self.assertEqual(counts["ERROR"], 2)
        self.assertEqual(counts["WARNING"], 2)
        self.assertEqual(len(matches), 5)

    def test_cli_missing_file_returns_2(self):
        result = subprocess.run(
            [sys.executable, str(ANALYZER), str(PROJECT_ROOT / "missing.log")],
            capture_output=True, text=True,
        )
        self.assertEqual(result.returncode, 2)
        self.assertIn("cannot read", result.stderr)

    def test_cli_writes_output_file(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            output = Path(temp_dir) / "nested" / "report.txt"
            result = subprocess.run(
                [sys.executable, str(ANALYZER), str(SAMPLE_LOG), "--output", str(output)],
                capture_output=True, text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertTrue(output.exists())
            self.assertIn("Matching lines: 5", output.read_text(encoding="utf-8"))


if __name__ == "__main__":
    unittest.main()
