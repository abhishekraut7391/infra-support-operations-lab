#!/usr/bin/env bash
set -u

usage() {
  echo "Usage: $0 HOSTNAME_OR_IP [SECOND_TARGET]" >&2
  exit 2
}

[[ $# -ge 1 && $# -le 2 ]] || usage

check_target() {
  local target="$1"
  echo
  echo "=== Target: $target ==="

  if command -v getent >/dev/null 2>&1; then
    if getent ahosts "$target" >/dev/null 2>&1; then
      echo "[DNS] Resolution succeeded"
      getent ahosts "$target" | head -n 5
    else
      echo "[DNS] Resolution failed or no address returned"
    fi
  else
    echo "[DNS] getent not available; skipping name-resolution check"
  fi

  if command -v ping >/dev/null 2>&1; then
    if ping -c 2 -W 2 "$target" >/dev/null 2>&1; then
      echo "[ICMP] Ping received a reply"
    else
      echo "[ICMP] No ping reply (ICMP may be blocked; this alone does not prove outage)"
    fi
  else
    echo "[ICMP] ping not available; skipping"
  fi
}

check_target "$1"
if [[ $# -eq 2 ]]; then
  check_target "$2"
fi
