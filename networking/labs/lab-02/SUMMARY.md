# Nmap Lab – SOC Findings Summary

## 1. Objective

Perform active reconnaissance using Nmap against two internal lab hosts to identify:

* Open ports
* Running services
* OS fingerprinting
* Potential risks relevant to SOC monitoring and detection

This exercise simulates what a SOC analyst may discover during internal threat hunting, triage of suspicious activity, or incident response.

---

## 2. Scope

Targets:

* `target1` – 10.0.0.11
* `target2` – 10.0.0.12

Scanning Methods:

* Version & OS detection: `sudo nmap -sV -O target1 target2`
* Aggressive scan: `sudo nmap -A target1 target2`

---

## 3. Key Findings

### 3.1 Host: 10.0.0.11 (target1)

**Open Services**

| Port    | Service | Version       |
| ------- | ------- | ------------- |
| 22/tcp  | SSH     | OpenSSH 8.9p1 |
| 80/tcp  | HTTP    | Apache 2.4.52 |
| 139/tcp | SMB     | Samba 4.6.2   |
| 445/tcp | SMB     | Samba 4.6.2   |

**OS Detection**

* Likely Linux kernel 4.x – 5.x

**Observations**

* SMB signing enabled but **not required**, increasing susceptibility to MITM attacks.
* Apache default webpage exposed—may indicate baseline or misconfiguration.
* SSH running with identifiable public keys (standard but useful for fingerprinting).

**Security Impact**

* SMB exposure increases attack surface (e.g., NTLM relay, enumeration).
* Default web server page may reveal platform information to attackers.
* SOC should monitor for:

  * Failed SMB and SSH login patterns
  * Web probing against port 80
  * Unusual internal lateral movement

---

### 3.2 Host: 10.0.0.12 (target2)

**Open Services**

| Port   | Service | Version       |
| ------ | ------- | ------------- |
| 21/tcp | FTP     | vsftpd 3.0.5  |
| 22/tcp | SSH     | OpenSSH 9.6p1 |

**OS Detection**

* Likely Linux kernel 4.x – 5.x

**Observations**

* FTP exposed — may allow plaintext credential transmission.
* SSH accessible with fingerprinted host keys.

**Security Impact**

* FTP historically introduces risk (clear-text passwords, anonymous login potential).
* SOC should monitor for:

  * FTP authentication attempts
  * Data exfiltration attempts
  * Brute force attempts against SSH

---

## 4. Overall Risk Assessment

| Host      | Risk Level | Reason                                                 |
| --------- | ---------- | ------------------------------------------------------ |
| 10.0.0.11 | Medium     | SMB exposure + service enumeration potential           |
| 10.0.0.12 | Medium     | FTP service increases credential theft and misuse risk |

---

## 5. Recommendations

### Target1 (10.0.0.11)

* Enable **mandatory SMB signing** to prevent relay attacks.
* Restrict SMB exposure only to approved hosts.
* Replace or remove default Apache webpage if not needed.
* Configure SOC alerts for SMB access anomalies.

### Target2 (10.0.0.12)

* Replace FTP with SFTP or FTPS if possible.
* If FTP must remain:

  * Enforce strong credentials
  * Disable anonymous access
  * Restrict to internal trusted hosts
* Add SOC rules for unusual FTP transfer volume.

### Both Hosts

* Harden SSH configuration:

  * Disable password authentication where possible
  * Enable fail2ban or logging-based lockouts

---

## 6. SOC Relevance

This lab demonstrates core SOC skills:

* Host enumeration and scanning identification
* Assessing discovered services for realistic risks
* Translating technical scan results into actionable security findings
* Prioritizing remediation and alerting strategy

This mirrors real-world SOC tasks including:

* Internal vulnerability sweeps
* Post-compromise scoping
* Proactive threat hunting
* Incident triage and reports

---

## 7. Evidence

### Commands Executed

```
sudo nmap -sV -O target1 target2
sudo nmap -A target1 target2
```

Outputs stored in this repository as:

* `scan-version-os.txt`
* `scan-aggressive.txt`

---

## 8. Conclusion

The scan provided visibility into exposed services and potential internal risks. Reviewing these findings reinforces SOC practices in detection engineering, service baseline mapping, and prioritizing host security improvements.
