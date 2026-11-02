# Contributing

This is a learning-focused repository. Keep examples safe, reproducible, and free of real credentials, customer information, or production data.

## Before submitting changes

- Explain the operational problem the change addresses.
- Prefer read-only diagnostics and avoid destructive defaults.
- Run Python tests: `python3 -m unittest discover -s tests -v`.
- Check shell syntax: `bash -n scripts/server_health_check.sh scripts/check_connectivity.sh`.
- Update documentation and sample data when behavior changes.

## Repository map

- `scripts/`: Bash and Python diagnostic tools.
- `sql/`: MySQL schema, fictional sample data, and practice queries.
- `docs/`: Concepts, troubleshooting workflow, and incident runbooks.
- `tests/`: Automated tests for the log analyzer.
- `.github/workflows/`: GitHub Actions validation.
