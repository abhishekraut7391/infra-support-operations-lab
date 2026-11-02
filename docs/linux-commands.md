# Linux Command Reference

Run commands on a Linux system or virtual machine that you own or are authorized to inspect. Some commands may vary by distribution.

## Navigation and files

| Command | Purpose | Example |
|---|---|---|
| `pwd` | Show current directory | `pwd` |
| `ls -lah` | List files, including hidden files and sizes | `ls -lah /var/log` |
| `cd` | Change directory | `cd /var/log` |
| `cat` | Print a small text file | `cat /etc/os-release` |
| `less` | Read a file page by page | `less /var/log/syslog` |
| `grep` | Search text | `grep -i error app.log` |
| `find` | Find files by criteria | `find /var/log -type f -name "*.log"` |

## System health

| Command | Purpose | Example |
|---|---|---|
| `uptime` | Uptime and load averages | `uptime` |
| `free -h` | Memory summary | `free -h` |
| `df -h` | Filesystem space | `df -h` |
| `du -sh PATH` | Directory size | `du -sh /var/log` |
| `top` | Live process/resource view | `top` |
| `ps aux` | Process snapshot | `ps aux --sort=-%mem | head` |

## Services and logs

| Command | Purpose | Example |
|---|---|---|
| `systemctl status NAME` | Inspect a service | `systemctl status ssh` |
| `journalctl -u NAME` | View service journal | `journalctl -u ssh --since "1 hour ago"` |
| `journalctl -p err` | Show error-priority messages | `journalctl -p err -n 50` |

Service names differ: some distributions use `ssh`, others `sshd`. Start with read-only status and log commands. Do not restart or modify services without authorization.

## Networking

| Command | Purpose | Example |
|---|---|---|
| `ip addr` | Interface addresses | `ip addr` |
| `ip route` | Routing table | `ip route` |
| `getent hosts NAME` | Name resolution | `getent hosts example.com` |
| `ping -c 4 HOST` | ICMP reachability test | `ping -c 4 1.1.1.1` |
| `ss -tulpen` | Listening sockets | `ss -tulpen` |
| `traceroute HOST` | Route path (may need install/permissions) | `traceroute example.com` |

## Permissions and ownership

- `ls -l` displays owner, group, and permission bits.
- `chmod` changes permissions; understand the impact before using it.
- `chown` changes ownership and usually requires elevated privileges.
- `sudo` runs an approved command with elevated privileges; never use it to bypass change control.

Prefer observation before action: collect the exact error, timestamp, host, command, and output before escalating.
