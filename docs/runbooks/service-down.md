# Runbook: Service Appears Down

## 1. Confirm the symptom

Capture the service name, host, user impact, exact error, and first observed time. Check whether one user or multiple users are affected.

## 2. Inspect service state

```bash
systemctl status SERVICE_NAME --no-pager
```

Use the actual service name for the Linux distribution (for example, `ssh` or `sshd`).

## 3. Inspect recent logs

```bash
journalctl -u SERVICE_NAME --since "30 minutes ago" --no-pager
```

Look for configuration errors, dependency failures, permission issues, resource pressure, and recent changes.

## 4. Check host resources

```bash
uptime
free -h
df -h
ps aux --sort=-%cpu | head
```

## 5. Escalate with evidence

Share the timestamp, service status, relevant log excerpts, resource observations, impact, and changes noticed. Restarting or changing a service is not part of this read-only runbook; follow approval and change-control procedures.
