# Runbook: High Disk Usage

## Purpose

Collect evidence when a filesystem reports high utilization. Commands are read-only.

## 1. Confirm the affected filesystem

```bash
df -h
df -i
```

Check both capacity and inode usage. Record the mount point and utilization.

## 2. Identify large directories

Use the affected mount point instead of scanning unrelated filesystems.

```bash
sudo du -xhd1 /var 2>/dev/null | sort -h
```

Use elevated access only when authorized. Do not delete files as part of diagnosis.

## 3. Inspect logs and open deleted files

```bash
sudo journalctl --disk-usage
sudo lsof +L1
```

A deleted file can still consume space while a process holds it open. Confirm findings with the system owner.

## 4. Document and escalate

Record filesystem, utilization, largest directories, relevant log growth, timestamps, and business impact. Request approval and follow local change procedures before cleanup, rotation changes, or service restarts.

## Safety

Never run broad destructive commands such as `rm -rf` as a troubleshooting shortcut. Preserve evidence and obtain approval before changing data.
