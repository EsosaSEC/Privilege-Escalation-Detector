# Privilege Escalation Detector

A bash script to detect suspicious `sudo` or `su` commands (e.g., `useradd`, `rm`) in `/var/log/auth.log` that may indicate privilege escalation attempts.

## Usage
1. Ensure `config.sh` with `AUTH_LOG` and `ALERTS_LOG`.
2. Run:
   ```bash
   sudo ./priv_escalation.sh
   ```
3. Check alerts in the log file.

## Dependencies
- grep, awk.

## Example Alert
   ```bash
   [2025-07-11 11:17:00] ALERT: Suspicious privilege escalation: sudo: user : COMMAND=/usr/sbin/useradd johndoe
   ```
