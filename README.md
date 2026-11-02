# IT Infrastructure & Support Operations Lab

[![Project checks](https://github.com/abhishekraut7391/infra-support-operations-lab/actions/workflows/ci.yml/badge.svg)](https://github.com/abhishekraut7391/infra-support-operations-lab/actions/workflows/ci.yml)

A hands-on portfolio project demonstrating practical Linux administration, basic network troubleshooting, log analysis, SQL-based support tracking, and incident documentation.

> **Learning project:** All incidents, hostnames, users, IP addresses, and ticket records in this repository are fictional or intentionally generic. The scripts are designed for read-only diagnostics and do not change system configuration.

## What this project demonstrates

| Area | Practical evidence |
|---|---|
| Linux operations | Server health snapshot, process/disk/memory/service inspection, useful command reference |
| Networking | DNS resolution, connectivity checks, IP/route/socket inspection, troubleshooting runbooks |
| Log analysis | Python utility that summarizes common error and warning patterns from text logs |
| SQL | MySQL schema and realistic support-ticket queries using filters, joins, grouping, and aggregates |
| Incident handling | Repeatable troubleshooting workflow, runbooks, and an incident report template |
| Engineering habits | Clear documentation, safe defaults, sample data, tests, and GitHub Actions checks |

## Repository map

```text
infra-support-operations-lab/
├── .github/workflows/       # Automated checks on push and pull request
├── docs/                    # Concepts, procedures, runbooks, and templates
├── sample_logs/             # Sanitized fictional log data
├── scripts/                 # Read-only Linux and Python diagnostic tools
├── sql/                     # MySQL schema, sample data, and support queries
├── tests/                   # Automated tests for the log analyzer
├── .gitignore
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Quick start

### 1. Clone the repository

```bash
git clone https://github.com/abhishekraut7391/infra-support-operations-lab.git
cd infra-support-operations-lab
```

### 2. Run the Linux server health check

On a Linux machine or Linux virtual machine:

```bash
chmod +x scripts/*.sh
./scripts/server_health_check.sh
```

The script prints a diagnostic snapshot and saves a timestamped report under `reports/`. It does not restart services, edit files, or require root access for its normal checks. Some optional details may be unavailable depending on the Linux distribution.

### 3. Check basic network connectivity

```bash
./scripts/check_connectivity.sh example.com 1.1.1.1
```

The script checks DNS resolution and sends a small number of ping probes. A failed ping alone does not prove a host is down; firewalls and network policies may block ICMP.

### 4. Analyze a sample log

Python 3.9 or newer is recommended. No third-party packages are required.

```bash
python3 scripts/log_analyzer.py sample_logs/sample_system.log
```

Save the summary to a file:

```bash
python3 scripts/log_analyzer.py sample_logs/sample_system.log --output reports/log-summary.txt
```

### 5. Explore the SQL support database

In MySQL Workbench, connect to a local MySQL 8.x server and use **File → Open SQL Script** for each file. Run them in this order, executing the whole script each time (lightning-bolt button or `Ctrl+Shift+Enter`):

1. `sql/schema.sql` (creates the `support_ops` database and tables)
2. `sql/sample_data.sql` (inserts fictional departments, assets, and tickets)
3. `sql/support_queries.sql` (run one query at a time with `Ctrl+Enter` to see each result)

The example data supports practice with `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `COUNT`, `AVG`, and `JOIN`.

### 6. Run the tests

```bash
python3 -m unittest discover -s tests -v
bash -n scripts/server_health_check.sh scripts/check_connectivity.sh
```

## Suggested demonstration flow (5–7 minutes)

1. Explain the scenario: a support engineer needs a quick, repeatable way to collect first-level diagnostics.
2. Run `server_health_check.sh` and explain CPU/load, memory, disk, services, and network sections.
3. Run `check_connectivity.sh` and explain the difference between DNS resolution and ICMP reachability.
4. Run `log_analyzer.py` on the fictional log and explain the error summary.
5. Show the MySQL support-ticket queries and explain how a support team can track open tickets and recurring issues.
6. Finish with one runbook and the incident report template to show how findings are documented and escalated.

## Important limitations

- This is a local learning lab, not a production monitoring platform.
- The health-check script reports observations; it does not diagnose every possible root cause.
- Ping can be blocked even when an application is reachable. Validate the relevant application port or URL separately.
- Log formats vary. The analyzer uses simple keyword and pattern matching, not a full syslog parser.
- SQL examples target MySQL 8.x syntax.
- Never upload real passwords, access tokens, customer data, private IP plans, production logs, or confidential company information.

## Learning outcomes

After completing the lab, you should be able to explain how you would:

- collect a basic Linux server health snapshot;
- investigate high disk usage, a stopped service, or an SSH connectivity issue;
- separate DNS, routing, and ICMP troubleshooting steps;
- identify recurring errors in a text log;
- track incidents and summarize ticket trends with SQL; and
- document evidence, actions, impact, and escalation clearly.

## Next improvements

Good future extensions include a Docker-based disposable Linux lab, CSV export for log summaries, additional unit tests, and a small dashboard. Add these only after you understand the current scripts and can explain each part.

## Author

**Abhishek Raut**  
M.Sc. Computer Science | IT Infrastructure & Support Learning Portfolio  
GitHub: [abhishekraut7391](https://github.com/abhishekraut7391)

This repository is a demonstration of self-directed learning. Describe only the tasks you have personally run, tested, and understood in interviews.
