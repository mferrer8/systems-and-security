# **01-Network-Service-Enumeration**

## Overview

This document captures the results of Part A of the network-service enumeration lab performed using:

* **Ubuntu Analyst VM** (10.0.0.10)
* **Metasploitable2 VM** (10.0.0.20)
* Internal-only VirtualBox network (no external exposure)

The goal is to simulate attacker enumeration behavior and analyze it from a SOC perspective, while learning the fundamentals of network discovery, service fingerprinting, and insecure protocol analysis.

---

# 1. Host Discovery

### 1.1 ping

```
ping 10.0.0.20
```

Verifies basic ICMP connectivity. Attackers use this to detect live hosts. SOC analysts watch for unusual ICMP sweeps.

### 1.2 arp -a

```
arp -a
```

Displays MAC-to-IP mappings the system has learned. Useful for detecting live hosts even when ICMP is blocked.

### 1.3 nmap host discovery scan

```
nmap -sn 10.0.0.0/24
```

Performs a ping sweep across the subnet.
SOC analysts often detect this via IDS signatures (horizontal scanning, host enumeration).

**Result:** Metasploitable2 (10.0.0.20) was identified as online.

---

# 2. Port & Service Enumeration

### 2.1 Version + Default Script Scan

```
nmap -sV -sC 10.0.0.20
```

* `-sV` identifies service versions
* `-sC` runs default Nmap scripts
* Used by attackers for service fingerprinting
* SOC analysts detect these via Nmap-style scan fingerprints (TTL patterns, probe signatures)

**Result Summary:**

Metasploitable2 exposes numerous insecure and deprecated services:

| Port | Service    | Notes                              |
| ---- | ---------- | ---------------------------------- |
| 21   | FTP        | Allows anonymous login             |
| 23   | Telnet     | Unencrypted remote login           |
| 25   | SMTP       | May allow open relay               |
| 80   | Apache     | Outdated version                   |
| 8180 | Tomcat     | Known vulnerable manager interface |
| 6667 | UnrealIRCd | Known backdoor version             |

These findings indicate a deliberately vulnerable system ideal for SOC detection and attacker simulation.

---

# 3. Telnet Enumeration

Telnet is an insecure, plaintext remote login protocol. Its presence is a strong indicator of risk and is a common entry point in beginner labs.

### 3.1 Connecting to Telnet

```
telnet 10.0.0.20 23
```

### Output:

```
Trying 10.0.0.20...
Connected to 10.0.0.20.
Escape character is '^]'.

                _                  _       _ _        _     _      ____  
 _ __ ___   ___| |_ __ _ ___ _ __ | | ___ (_) |_ __ _| |__ | | ___|___ \ 
| '_ ` _ \ / _ \ __/ _` / __| '_ \| |/ _ \| | __/ _` | '_ \| |/ _ \ __) |
| | | | | |  __/ || (_| \__ \ |_) | | (_) | | || (_| | |_) | |  __// __/ 
|_| |_| |_|\___|\__\__,_|___/ .__/|_|\___/|_|\__\__,_|_.__/|_|\___|_____|
                            |_|                                          

Warning: Never expose this VM to an untrusted network!
Login with msfadmin/msfadmin to get started

metasploitable login:
Connection closed by foreign host.
```

### Key Takeaways

* The Telnet banner openly displays the OS and purpose — highly insecure.
* Full login prompt is transmitted in plaintext.
* Attackers rely heavily on banner information.
* SOC analysts detect this as high-risk: plaintext credentials, legacy protocol, no encryption.

---

# 4. tcpdump Analysis of Telnet Traffic

### 4.1 Command Used

```
sudo tcpdump -i enp0s3 tcp port 23 -A
```

Explanation:

| Flag          | Meaning                                                        |
| ------------- | -------------------------------------------------------------- |
| `-i enp0s3`   | Capture packets on this interface                              |
| `tcp port 23` | Filter only Telnet traffic                                     |
| `-A`          | Print packet payload in ASCII (useful for plaintext protocols) |

### Why this matters for SOC analysts

* Telnet leaks complete session data.
* Analysts can identify credentials, commands, banners.
* This demonstrates why insecure protocols are critical alerts in enterprise networks.

---

## 4.2 Key Packet Observations

### TCP Handshake

```
S → S/ACK → ACK
```

A normal three-way handshake shows successful session establishment.

### Telnet Option Negotiation

Packets included multiple:

* DO TERMINAL TYPE
* WILL TERMINAL TYPE
* DO ECHO
* WILL SUPPRESS GO AHEAD
* SB TERMINAL TYPE IS ...

This is the Telnet client and server negotiating capabilities.
Analysts should recognize these signatures when reviewing packet captures.

### Banner Transmission

A large packet (~620 bytes) contained:

* Full ASCII Metasploitable2 login banner
* Warning message
* Login prompt

This proves that **all Telnet banner and login prompts are visible in plaintext**.

### Connection Termination

```
F → F/ACK → ACK
```

A clean bidirectional FIN/ACK close.

---

# 5. netcat (nc) Use Case

### Example Command

```
nc -nv 10.0.0.20 23
```

Explanation:

| Flag | Meaning            |
| ---- | ------------------ |
| `-n` | Do not resolve DNS |
| `-v` | Verbose output     |

Netcat acts as a simple TCP client. Useful for:

* Banner grabbing
* Testing raw connections
* Verifying open ports

SOC analysts often see attackers using netcat for reconnaissance.

---

# 6. Indicators of Exposure

From enumeration activities, the following exposures were documented:

* Telnet running on port 23 (legacy, plaintext authentication)
* FTP allowing anonymous login
* UnrealIRCd backdoor signature present on port 6667
* Outdated Tomcat service exposed on 8180
* Multiple services returning verbose version banners

These are all early-stage attacker entry points and high-severity SOC alerts.

---

# 7. SOC vs Pentester Perspective

| Role               | How this activity applies                                                                                                         |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| SOC Analyst        | Detects host scans, Telnet use, legacy protocol activity, suspicious enumeration, banner grabbing, and lateral movement attempts. |
| Penetration Tester | Performs the same enumeration to identify weak services, capture banners, test credentials, and escalate further.                 |

Both roles require understanding:

* Handshake patterns
* Enumeration behavior
* What normal vs suspicious traffic looks like
* How insecure protocols reveal sensitive data

---

# 8. Summary

In this lab, we successfully:

1. Identified a live target using ICMP, ARP, and Nmap scans.
2. Enumerated exposed services and version data.
3. Performed Telnet banner grabbing.
4. Captured full Telnet negotiation and banner transfer using tcpdump.
5. Documented exposures and highlighted their significance to SOC detection workflows.

This completes Part A of the SOC Foundations exercises.
