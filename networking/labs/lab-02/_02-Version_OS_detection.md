# 02 – Version and OS Detection

## Objective

The goal of this phase is to expand beyond simple host discovery and determine:

* Operating system families and possible kernel ranges
* Software and service versions running on open ports
* Host fingerprinting characteristics observable through network responses

This information is useful for threat mapping, vulnerability identification, and understanding what an attacker or SOC analyst can infer from remote scans.

---

## Lab Setup

Internal virtual lab network:

| Role         | Example IP (Sanitized) |
| ------------ | ---------------------- |
| Analyst Host | 10.0.0.x               |
| Target 1     | 10.0.0.x               |
| Target 2     | 10.0.0.x               |

All systems are isolated from the internet and used purely for controlled cybersecurity practice.

---

## Command Used

Executed from the analyst system:

```
sudo nmap -sV -O target1 target2
```

### Key Options

| Option | Meaning                                                         |
| ------ | --------------------------------------------------------------- |
| `-sV`  | Probe open ports to gather service and version information      |
| `-O`   | Attempt OS fingerprinting based on network behavior             |
| `-Pn`  | Not used here, but Nmap still proceeded due to hosts responding |

---

## Nmap Output (Sanitized)

### Target 1

```
Scan report for target1 (10.0.0.x)
Host is up.
Not shown: 996 closed tcp ports (reset)
PORT    STATE SERVICE     VERSION
22/tcp  open  ssh         OpenSSH 8.9p1 (Ubuntu Linux; protocol 2.0)
80/tcp  open  http        Apache httpd 2.4.52
139/tcp open  netbios-ssn Samba smbd 4.6.2
445/tcp open  netbios-ssn Samba smbd 4.6.2
Device type: general purpose
Running: Linux 4.X|5.X
OS CPE: cpe:/o:linux:linux_kernel
OS details: Linux kernel 4.15 – 5.8
Network Distance: 1 hop
```

### Target 2

```
Scan report for target2 (10.0.0.x)
Host is up.
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.5
22/tcp open  ssh     OpenSSH 9.6p1 (Ubuntu Linux; protocol 2.0)
Device type: general purpose
Running: Linux 4.X|5.X
OS CPE: cpe:/o:linux:linux_kernel
OS details: Linux kernel 4.15 – 5.8
Network Distance: 1 hop
```

---

## Observations

* Both hosts run Linux systems with kernel profiles indicating 4.x to 5.x variants.
* Version probing revealed clear service banners:

  * Apache HTTP server on Target 1
  * Samba services on Target 1
  * vsftpd and SSH on Target 2
* These banners are the kind of intelligence often used by intrusion analysts when correlating:

  * Known vulnerabilities (CVE matching)
  * Baseline configurations
  * Indicators of compromise
* The OS fingerprinting results align with common Nmap TCP stack profiling methods, confirming the systems are behaving as standard Linux hosts.

---

## Status

Version and OS fingerprinting is complete.
The next phase will perform deeper enumeration and script-assisted analysis.
