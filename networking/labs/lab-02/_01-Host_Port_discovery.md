# 01 – Host and Port Discovery

## Objective

The purpose of this phase is to perform an initial reconnaissance sweep against the lab network to identify:

* Which hosts are online
* Which TCP ports are open
* How the network responds to SYN-based scanning

This establishes a baseline for deeper enumeration performed in later stages.

---

## Lab Setup

Three virtual machines exist on an isolated internal network:

| Role         | Example IP (Sanitized) |
| ------------ | ---------------------- |
| Analyst Host | 10.0.0.x               |
| Target 1     | 10.0.0.x               |
| Target 2     | 10.0.0.x               |

All scanning and packet captures were performed strictly inside the lab environment.

---

## Packet Capture Configuration

Three terminals were used simultaneously.

### Terminal 1 – Packet Capture to File

```
sudo tcpdump -i enp0s3 '(host 10.0.0.x or host 10.0.0.x)' -w capture.pcap
```

### Terminal 2 – Live Traffic View

```
sudo tcpdump -i enp0s3 -vv -n
```

### Terminal 3 – Nmap Scanning

Performed host discovery and full TCP port sweep:

```
sudo nmap -Pn -sS --min-rate 1500 -p- target1 target2
```

Key options:

* `-Pn` – Skip host ping checks
* `-sS` – TCP SYN scan
* `--min-rate 1500` – Faster packet transmission, suitable for a contained lab
* `-p-` – Scan all 65,535 TCP ports

---

## Nmap Output (Sanitized)

### Target 1

```
Scan report for target1 (10.0.0.x)
Host is up.
Not shown: 65531 closed tcp ports (reset)
PORT    STATE SERVICE
22/tcp  open  ssh
80/tcp  open  http
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
MAC Address: Oracle VirtualBox virtual NIC
```

### Target 2

```
Scan report for target2 (10.0.0.x)
Host is up.
Not shown: 65533 closed tcp ports (reset)
PORT   STATE SERVICE
21/tcp open  ftp
22/tcp open  ssh
MAC Address: Oracle VirtualBox virtual NIC
```

---

## Observations

* Both target systems responded to probes, confirming they are online.
* Target 1 presented common SMB and HTTP services.
* Target 2 exposed FTP and SSH.
* The large number of `reset` responses indicates closed ports handled normally by the operating systems.
* SYN scanning behavior was successfully captured for later analysis, although live capture produced a high packet volume and is not included here.

---

## Status

Host discovery and initial port enumeration are complete. Subsequent stages will perform version detection, OS fingerprinting, and deeper enumeration.
