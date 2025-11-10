# Network Basics

This document covers the foundational networking concepts every SOC Analyst should understand — including IP addresses, subnets, ports, and essential network analysis tools.  
These fundamentals are critical for investigating alerts, analyzing traffic, and understanding how systems communicate on a network.

---

## 1. IP Addresses

### IPv4
- **Format:** 32-bit address written as four decimal octets (e.g., `192.168.1.10`)
- **Range:** `0.0.0.0` – `255.255.255.255`
- **Private Address Ranges:**
  - Class A: `10.0.0.0/8`
  - Class B: `172.16.0.0/12`
  - Class C: `192.168.0.0/16`
- **Loopback Address:** `127.0.0.1`
- **Broadcast Address:** e.g., `192.168.1.255` (used to send to all hosts on the subnet)

### IPv6
- **Format:** 128-bit hexadecimal notation separated by colons (e.g., `2001:db8::1`)
- **Purpose:** Created to replace IPv4 and support the expanding number of connected devices
- **Special Address Types:**
  - Loopback: `::1`
  - Link-local: `fe80::/10`
  - Unique local: `fc00::/7`
- **Key Difference:** IPv6 eliminates the need for NAT, supporting end-to-end communication.

### SOC Relevance
- Recognize internal vs external IP addresses in logs
- Identify potential lateral movement based on private IP patterns
- Understand NAT and how it can obscure true source IPs

---

## 2. Subnetting

Subnetting divides large networks into smaller segments, improving performance and security.

### Key Concepts
- **Subnet Mask:** Defines which part of the IP identifies the network vs the host  
  Example: `255.255.255.0` or `/24`
- **CIDR Notation:** Short form expressing subnet size  
  - `/24` = 255.255.255.0 (256 addresses)  
  - `/16` = 255.255.0.0 (65,536 addresses)
- **Network ID:** Identifies the subnet  
- **Broadcast Address:** Last address in the subnet, used to contact all hosts

### SOC Relevance
- Helps analysts determine the network segment where an alert originated  
- Assists in identifying whether a connection came from within the same subnet or an external network  
- Useful for correlating logs across multiple network devices

---

## 3. Ports and Protocols

### Common TCP/UDP Ports
| Service | Protocol | Port |
|----------|-----------|------|
| HTTP | TCP | 80 |
| HTTPS | TCP | 443 |
| DNS | UDP/TCP | 53 |
| SSH | TCP | 22 |
| FTP | TCP | 21 |
| SMTP | TCP | 25 |
| POP3 | TCP | 110 |
| IMAP | TCP | 143 |
| RDP | TCP | 3389 |
| SMB | TCP | 445 |

### SOC Relevance
- Port activity helps identify protocol misuse and potential compromise  
- Unusual ports (e.g., outbound traffic on nonstandard ports) can indicate tunneling or exfiltration  
- Understanding TCP vs UDP aids in analyzing packet captures and firewall logs

---

## 4. Core Network Analysis Tools

| Tool | Purpose | SOC Application |
|------|----------|-----------------|
| **ping** | Tests reachability between hosts | Confirms if a host is online or blocked by a firewall |
| **traceroute / tracert** | Maps path packets take across the network | Identifies routing issues or unexpected network paths |
| **nslookup / dig** | Resolves domain names to IP addresses | Detects DNS hijacking or suspicious domains |
| **netstat / ss** | Displays network connections and open ports | Detects unauthorized connections or malware activity |
| **Wireshark / tcpdump** | Captures and analyzes packets | Deep analysis of network behavior or attack indicators |
| **nmap** | Scans networks and identifies open ports/services | Used to map the attack surface or confirm patching status |

---

## 5. Key Takeaways

- Every SOC analyst should understand how IP addressing, subnets, and ports work together to define network communication.
- Familiarity with common tools like Wireshark and Nmap is essential for traffic analysis and incident investigation.
- Recognizing network patterns and anomalies is fundamental to identifying potential threats early.

---
