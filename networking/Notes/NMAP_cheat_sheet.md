# Nmap Cheat Sheet – SOC Analyst Edition

## Overview

Nmap is a critical tool for SOC analysts, incident responders, and threat hunters. It is used for:

* Host and network discovery
* Port and service enumeration
* OS and application fingerprinting
* Detecting vulnerabilities via NSE scripts
* Investigating suspicious lateral movement
* Verifying alerts and network posture

This cheat sheet focuses on real-world commands commonly used in SOC work.

---

# 1. Basic Scanning

## Ping Sweep (Find Live Hosts)

```
nmap -sn 10.0.0.0/24
```

## Basic Single Host Scan

```
nmap 10.0.0.11
```

## Multiple Hosts

```
nmap 10.0.0.11 10.0.0.12
nmap target1 target2
```

---

# 2. Port Scanning

## Scan Top 1000 Ports (Default)

```
nmap 10.0.0.11
```

## Scan All Ports (1–65535)

```
nmap -p- 10.0.0.11
```

## Scan Specific Ports

```
nmap -p 22,80,443 10.0.0.11
```

## Scan Port Range

```
nmap -p 1-1000 10.0.0.11
```

---

# 3. Service & OS Fingerprinting

## Service Version Detection

```
nmap -sV 10.0.0.11
```

## OS Detection + Versions

```
nmap -sV -O 10.0.0.11
```

## Aggressive Scan (Most Detailed Normal Mode)

```
nmap -A 10.0.0.11
```

---

# 4. Stealth Techniques

## SYN (Stealth) Scan

```
nmap -sS 10.0.0.11
```

## TCP Connect Scan (No Admin Required)

```
nmap -sT 10.0.0.11
```

## UDP Scan

```
nmap -sU 10.0.0.11
```

---

# 5. Host Discovery

## Disable ICMP Ping (Scan Even If Host Blocks ICMP)

```
nmap -Pn 10.0.0.11
```

## ICMP Echo Discovery Only

```
nmap -PE 10.0.0.0/24
```

---

# 6. NSE Script Scanning

## Default Script Scan

```
nmap -sC 10.0.0.11
```

## Everything SMB Related

```
nmap --script smb* 10.0.0.11
```

## Vulnerability Script Set

```
nmap --script vuln 10.0.0.11
```

## Single Named Script Example

```
nmap --script smb-enum-shares 10.0.0.11
```

---

# 7. Output & Logging

## Save to Normal Text Output

```
nmap -oN scan.txt 10.0.0.11
```

## Save as XML (For Parsing, SOAR, Dashboards)

```
nmap -oX scan.xml 10.0.0.11
```

## Save All Formats (.nmap, .xml, .gnmap)

```
nmap -oA results 10.0.0.11
```

---

# 8. Performance & Speed

## Faster Execution

```
nmap -T4 10.0.0.11
```

## Slow & Stealthy

```
nmap -T1 10.0.0.11
```

## Higher Parallelism (Faster)

```
nmap --min-parallelism 50 10.0.0.11
```

---

# 9. Network Troubleshooting for SOC

## Traceroute

```
nmap --traceroute 10.0.0.11
```

## OS Guessing With Fingerprint Expansion

```
nmap -O --osscan-guess 10.0.0.11
```

---

# 10. Practical SOC Use Cases

## Investigate Lateral Movement

```
nmap -sV -O -Pn 10.0.0.11
```

## Check FTP Server Configuration Weaknesses

```
nmap --script ftp-anon -p 21 10.0.0.11
```

## Enumerate Windows Shares (Common in IR)

```
nmap --script smb-enum-shares 10.0.0.11
```

## Identify Rogue Devices Quickly

```
nmap -sn 10.0.0.0/24
```

---

# 11. Useful NSE Script Categories

| Category  | Purpose                   |
| --------- | ------------------------- |
| vuln      | Vulnerability checks      |
| default   | Common enumeration        |
| auth      | Authentication weaknesses |
| discovery | Host & service discovery  |
| safe      | Non-intrusive scans       |
| intrusive | May disrupt production    |

Run multiple categories:

```
nmap --script vuln,auth 10.0.0.11
```

---

# 12. Nmap Best Practices for SOC

* Always log output with `-oN` or `-oA`
* Use `-Pn` when ICMP is blocked
* Pair scanning with packet captures when possible
* Use NSE for targeted data gathering
* Keep XML output for automation pipelines

---

# 13. Top 20 Nmap Commands Every SOC Analyst Should Know

```
1)  nmap -sn 10.0.0.0/24
2)  nmap 10.0.0.11
3)  nmap -p- 10.0.0.11
4)  nmap -p 22,80,443 10.0.0.11
5)  nmap -sS 10.0.0.11
6)  nmap -sT 10.0.0.11
7)  nmap -sU 10.0.0.11
8)  nmap -sV 10.0.0.11
9)  nmap -O 10.0.0.11
10) nmap -A 10.0.0.11
11) nmap -Pn 10.0.0.11
12) nmap --script vuln 10.0.0.11
13) nmap --script smb* 10.0.0.11
14) nmap -T4 10.0.0.11
15) nmap -T1 10.0.0.11
16) nmap -oN results.txt 10.0.0.11
17) nmap -oA results 10.0.0.11
18) nmap --traceroute 10.0.0.11
19) nmap -sC 10.0.0.11
20) nmap --top-ports 1000 10.0.0.11
```

---

# 14. References

* Nmap Official Documentation
* Nmap NSE Reference
* Internal SOC guidelines (if applicable)

---

This file can be used as:

* Study notes
* GitHub documentation
* SOC playbook reference
* Field quick-reference guide
