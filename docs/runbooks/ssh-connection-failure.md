# Runbook: SSH Connection Failure

## 1. Capture the exact failure

Record the client source, destination hostname/IP, SSH port, timestamp, and full error text. Do not share private keys or passwords.

## 2. Check name resolution and route

```bash
getent hosts SERVER_NAME
ip route get SERVER_IP
```

## 3. Check port reachability

Where available and authorized:

```bash
nc -vz SERVER_NAME 22
```

A timeout, refusal, and DNS error indicate different failure points. A successful TCP connection does not prove authentication will succeed.

## 4. Check server-side evidence (authorized access only)

```bash
systemctl status sshd --no-pager
journalctl -u sshd --since "30 minutes ago" --no-pager
ss -tlnp | grep ':22'
```

Some distributions name the unit `ssh` instead of `sshd`.

## 5. Escalate safely

Provide timestamps, source/destination, port, client error, DNS/route/port results, and server-side logs if authorized. Never disable firewall rules, weaken SSH configuration, or change authentication settings without explicit approval.
