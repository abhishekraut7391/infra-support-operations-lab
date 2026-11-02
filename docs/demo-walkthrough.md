# Demo Walkthrough

Use this short flow to demonstrate the lab in an interview or technical discussion. Run commands only on a machine you own or are authorized to inspect.

## 1. Explain the purpose

"This project is a hands-on lab for practising first-level infrastructure support. It collects basic system evidence, checks simple network reachability, summarizes sample logs, and models support tickets in MySQL."

## 2. Run host diagnostics

```bash
chmod +x scripts/*.sh
./scripts/server_health_check.sh
```

Explain what you learn from uptime/load, memory, disk usage, process listings, and service checks. Mention that the report is observational and does not change configuration.

## 3. Check DNS and reachability

```bash
./scripts/check_connectivity.sh example.com 1.1.1.1
```

Explain that DNS resolution and ping test different things. A host may resolve correctly but block ICMP.

## 4. Triage the sample log

```bash
python3 scripts/log_analyzer.py sample_logs/sample_system.log
```

Point out the severity counts and explain that pattern matching identifies lines for review; it does not prove root cause.

## 5. Explore ticket data

Open the SQL scripts in MySQL Workbench and execute schema, sample data, and queries in order. Explain one filter, one join, and one grouped count.

## 6. Close with incident communication

Show a runbook and `docs/incident-report-template.md`. Explain how you record the symptom, impact, checks performed, findings, next action, and escalation details.

## Interview honesty

Describe this as a self-learning project. Do not claim production usage or operational experience that you have not personally performed.
