#!/usr/bin/env bash
# Read-only Linux host health snapshot for support practice.
set -u

timestamp() { date '+%Y-%m-%d %H:%M:%S %Z'; }

REPORT_DIR="reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/server-health-$(date '+%Y%m%d-%H%M%S').txt"

section() {
  printf '\n===== %s =====\n' "$1"
}

{
  echo "LINUX SERVER HEALTH SNAPSHOT"
  echo "Generated: $(timestamp)"
  echo "Hostname: $(hostname 2>/dev/null || echo unavailable)"
  echo "User: $(id -un 2>/dev/null || echo unavailable)"

  section "Operating system"
  if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    echo "${PRETTY_NAME:-Linux}"
  else
    uname -a
  fi

  section "Uptime and load"
  uptime 2>&1 || true

  section "Memory"
  free -h 2>&1 || echo "free command unavailable"

  section "Filesystem usage"
  df -hT 2>&1 || df -h 2>&1 || true

  section "Top CPU processes"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu 2>/dev/null | head -n 8 || ps aux | head -n 8

  section "Network addresses"
  if command -v ip >/dev/null 2>&1; then
    ip -brief address 2>&1 || ip address 2>&1
  else
    echo "ip command unavailable"
  fi

  section "Failed systemd units"
  if command -v systemctl >/dev/null 2>&1; then
    systemctl --failed --no-pager 2>&1 || true
  else
    echo "systemctl unavailable"
  fi

  section "Recent high-priority journal entries"
  if command -v journalctl >/dev/null 2>&1; then
    journalctl -p warning -n 10 --no-pager 2>&1 || true
  else
    echo "journalctl unavailable"
  fi

  echo
  echo "This report is observational. Review findings before taking action."
} | tee "$REPORT_FILE"

echo
echo "Report saved to: $REPORT_FILE"
