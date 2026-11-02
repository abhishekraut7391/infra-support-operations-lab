#!/usr/bin/env python3
"""Summarize common severity keywords in a text log (learning utility)."""
from __future__ import annotations

import argparse
import re
import sys
from collections import Counter
from pathlib import Path

PATTERNS = {
    "CRITICAL": re.compile(r"\b(critical|crit|fatal|emerg|alert)\b", re.IGNORECASE),
    "ERROR": re.compile(r"\b(error|err|failed|failure)\b", re.IGNORECASE),
    "WARNING": re.compile(r"\b(warn|warning)\b", re.IGNORECASE),
}


def analyze_lines(lines: list[str]) -> tuple[Counter[str], list[tuple[int, str, str]]]:
    """Return severity counts and matching (line number, severity, text) rows."""
    counts: Counter[str] = Counter()
    matches: list[tuple[int, str, str]] = []
    for line_number, raw_line in enumerate(lines, start=1):
        line = raw_line.rstrip("\n")
        for severity, pattern in PATTERNS.items():
            if pattern.search(line):
                counts[severity] += 1
                matches.append((line_number, severity, line))
                break
    return counts, matches


def build_report(source: Path, counts: Counter[str], matches: list[tuple[int, str, str]]) -> str:
    total = sum(counts.values())
    rows = [
        "LOG ANALYSIS SUMMARY",
        f"Source file: {source}",
        f"Matching lines: {total}",
        "",
        "Counts:",
        f"  CRITICAL: {counts.get('CRITICAL', 0)}",
        f"  ERROR:    {counts.get('ERROR', 0)}",
        f"  WARNING:  {counts.get('WARNING', 0)}",
        "",
        "Matched entries:",
    ]
    if not matches:
        rows.append("  No matching severity keywords found.")
    else:
        for line_number, severity, text in matches:
            rows.append(f"  line {line_number:>4} [{severity}] {text}")
    rows.extend(
        [
            "",
            "Note: This is keyword-based triage, not root-cause analysis. "
            "Verify timestamps, context, and related service metrics.",
        ]
    )
    return "\n".join(rows) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("log_file", type=Path, help="Path to a UTF-8 text log file")
    parser.add_argument("--output", type=Path, help="Optional path to write the report")
    args = parser.parse_args()

    try:
        with args.log_file.open("r", encoding="utf-8", errors="replace") as handle:
            counts, matches = analyze_lines(handle)
    except OSError as exc:
        print(f"Error: cannot read '{args.log_file}': {exc}", file=sys.stderr)
        return 2

    report = build_report(args.log_file, counts, matches)
    if args.output:
        try:
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_text(report, encoding="utf-8")
        except OSError as exc:
            print(f"Error: cannot write '{args.output}': {exc}", file=sys.stderr)
            return 2
    else:
        print(report, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
