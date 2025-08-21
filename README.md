# Privilege Escalation Detector
A standalone bash script to detect suspicious `sudo` and `su` commands (e.g., `useradd`, `passwd`, `rm`) in `/var/log/auth.log` that may indicate privilege escalation attempts.

 ## Usage
 1. Update `AUTH_LOG` in the script to your log file path (e.g., `/var/log/auth.log` or a copied log).
 2. Run:
    ```bash
    sudo ./priv_escalation.sh
    ```
 3. Check alerts in `./alerts/alerts.log`.

 ## Dependencies
 - `grep`, `tail` (standard on Linux).

 ## Example Alert
 ```
 [2025-08-21 15:04:00] ALERT: Suspicious privilege escalation: sudo: user : COMMAND=/usr/sbin/useradd testuser
 ```

 ## Notes
 - Fully standalone with no external configuration dependencies.
 - Line-by-line comments for clarity.
 - Tested in a lab with simulated privilege escalation on an Ubuntu VM.

 ## Author
 Esosa Okonedo
