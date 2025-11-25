# 03 – Aggressive Scan

## Objective

This phase performs an aggressive enumeration using Nmap to retrieve maximum detail in a single scan, including:

* Service and version detection
* OS fingerprinting
* Built-in NSE script results (where applicable)
* Traceroute information

Aggressive scanning provides deeper situational awareness useful for SOC analysts, penetration testers, and defenders reviewing external or internal reconnaissance activity. Due to its visibility and traffic footprint, this type of scan is not recommended on production networks.

---

## Lab Setup

Internal virtual lab environment:

| Role         | Example IP (Sanitized) |
| ------------ | ---------------------- |
| Analyst Host | 10.0.0.x               |
| Target 1     | 10.0.0.x               |
| Target 2     | 10.0.0.x               |

All systems are part of an isolated and controlled virtual network.

---

## Command Used

Executed from the analyst system:

```
sudo nmap -A target1 target2
```

### Key Flags

| Flag | Purpose                                                                  |
| ---- | ------------------------------------------------------------------------ |
| `-A` | Enables OS detection, version detection, default scripts, and traceroute |

This scan is significantly more intrusive and generates larger amounts of traffic, increasing the likelihood of detection on monitoring systems.

---

## Nmap Output (Sanitized)

### Target 1

```
Scan report for target1 (10.0.0.x)
Host is up.
Not shown: 996 closed tcp ports (reset)
PORT    STATE SERVICE     VERSION
22/tcp  open  ssh         OpenSSH 8.9p1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 <ECDSA fingerprint>
|_  256 <ED25519 fingerprint>
80/tcp  open  http        Apache httpd 2.4.52
|_http-server-header: Apache/2.4.52 (Ubuntu)
|_http-title: Default Apache Landing Page
139/tcp open  netbios-ssn Samba smbd 4.6.2
445/tcp open  netbios-ssn Samba smbd 4.6.2

Device type: general purpose  
Running: Linux 4.X–5.X  
OS CPE: cpe:/o:linux:linux_kernel  
OS Details: Linux kernel 4.15 – 5.8  
Network Distance: 1 hop
```

#### Host Script Results (Sanitized)

```
smb2-security-mode:
  Message signing enabled but not required

smb2-time:
  date: 2025-11-25TXX:XX:XX
  start_date: N/A

nbstat:
  NetBIOS name: TARGET1
```

#### Traceroute

```
HOP RTT     ADDRESS
1   1.3 ms  target1 (10.0.0.x)
```

---

### Target 2

```
Scan report for target2 (10.0.0.x)
Host is up.
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.5
22/tcp open  ssh     OpenSSH 9.6p1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 <ECDSA fingerprint>
|_  256 <ED25519 fingerprint>

Device type: general purpose  
Running: Linux 4.X–5.X  
OS CPE: cpe:/o:linux:linux_kernel  
OS Details: Linux kernel 4.15 – 5.8  
Network Distance: 1 hop
```

#### Traceroute

```
HOP RTT     ADDRESS
1   1.0 ms  target2 (10.0.0.x)
```

---

## Observations

* This scan confirmed previous findings and added greater detail through NSE script output and banner enumeration.
* Target 1 exposed more services than Target 2, including SMB and an HTTP server with visible header data.
* SMB info revealed:

  * Signing enabled but not mandatory, which may be a security consideration.
* SSH host keys were collected, which would allow visibility into host key persistence over time and potential man-in-the-middle concerns.
* Both targets show consistent OS profiles matching Linux kernel generations in the 4.x to 5.x range.

---

## Status

Aggressive scanning and deep enumeration are complete.
This phase concludes the initial Nmap evaluation of the lab hosts.
