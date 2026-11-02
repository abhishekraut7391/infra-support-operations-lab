# Architecture

This repository is a small, local-first support operations lab.

## Components

- **Bash diagnostics** collect host-level facts such as uptime, disk, memory, processes, and selected service states.
- **Connectivity checks** test DNS lookup and basic ICMP reachability for supplied targets.
- **Python log analyzer** scans a text log for common critical, error, and warning patterns and produces a concise report.
- **MySQL database** models departments, assets, and support tickets so that common service-desk queries can be practised.
- **Runbooks and templates** provide a repeatable approach to investigation, evidence collection, communication, and escalation.
- **GitHub Actions** runs unit tests and shell syntax checks on pushes and pull requests.

## Design principles

1. Prefer read-only checks and explicit target inputs.
2. Use fictional sample data; never commit production logs or credentials.
3. Keep each tool small enough to explain and troubleshoot.
4. Document limitations so that diagnostic output is not mistaken for a confirmed root cause.
