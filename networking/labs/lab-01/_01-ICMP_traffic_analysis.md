# Lab 01 — ICMP Traffic Analysis

## Overview

In this lab, we performed a basic analysis of ICMP (ping) traffic between the analyst host and two target machines in our internal lab network. The goal was to:

- Generate ICMP traffic using `ping`
- Capture traffic using `tcpdump`
- View packets live for immediate observation
- Record packets to a `.pcap` file for later analysis in Wireshark

This lab introduces hands-on packet capture, live monitoring, and basic network troubleshooting, which are fundamental skills for SOC analysts.

---

## Lab Setup

We used **three terminal windows** to organize the lab workflow:

1. **Terminal 1 — Capture ICMP traffic to a `.pcap` file**  
   Command:

   ```bash
   sudo tcpdump -i enp0s3 icmp -U -w ~/Desktop/networking/icmp-capture_L01.pcap
- -i enp0s3 → capture packets on the analyst’s internal interface
- icmp → filter only ICMP traffic
- -U → write packets to the file immediately (unbuffered)
- -w <file> → save the captured traffic in binary .pcap format for analysis in Wireshark

Terminal 2 — Live view of ICMP traffic
Command:

     ```bash
    sudo tcpdump -i enp0s3 icmp -vv -n
- -vv → verbose output for detailed packet fields
- -n → disables DNS resolution for faster, cleaner display
-Displays ICMP request and reply packets as they occur in real-time

Terminal 3 — Generate ICMP traffic using ping commands

From the analyst host:

    ```bash
    ping -c 2 target1
    ping -c 2 target2
- -c 2 → send 2 ICMP echo requests
-target1 and target2 are hostnames for lab targets

This setup allows simultaneous traffic generation, live monitoring, and recording for later analysis.

## Example ICMP Ping Output

Ping Target 1
```bash
PING target1 (10.0.0.y) 56(84) bytes of data.
64 bytes from target1: icmp_seq=1 ttl=64 time=1.88 ms
64 bytes from target1: icmp_seq=2 ttl=64 time=1.10 ms

--- target1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss
rtt min/avg/max/mdev = 1.104/1.492/1.880/0.388 ms
```
Ping Target 2
```bash
PING target2 (10.0.0.z) 56(84) bytes of data.
64 bytes from target2: icmp_seq=1 ttl=64 time=1.37 ms
64 bytes from target2: icmp_seq=2 ttl=64 time=1.76 ms

--- target2 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss
rtt min/avg/max/mdev = 1.367/1.565/1.763/0.198 ms
```
Example TCPDump Live Output
```bash
08:38:16.056590 IP analyst > target1: ICMP echo request, id 5774, seq 1, length 64
08:38:16.057255 IP target1 > analyst: ICMP echo reply, id 5774, seq 1, length 64
08:38:17.059174 IP analyst > target1: ICMP echo request, id 5774, seq 2, length 64
08:38:17.060261 IP target1 > analyst: ICMP echo reply, id 5774, seq 2, length 64
08:38:23.367292 IP analyst > target2: ICMP echo request, id 5775, seq 1, length 64
08:38:23.367670 IP target2 > analyst: ICMP echo reply, id 5775, seq 1, length 64
08:38:24.368183 IP analyst > target2: ICMP echo request, id 5775, seq 2, length 64
08:38:24.369927 IP target2 > analyst: ICMP echo reply, id 5775, seq 2, length 64
```
# Observations
- Each ping generated ICMP echo request and reply packets between the analyst host and the targets.
- Packet sizes, sequence numbers, and response times were visible in live capture.
- Traffic can now be opened in Wireshark for detailed inspection (e.g., analyzing headers, TTL values).
- Using separate terminals for capture, live view, and command execution simulates SOC analyst workflow.

# Notes
- Live viewing requires a separate terminal because tcpdump -w suppresses normal packet summary output.
- Captured .pcap files are reusable for later labs (e.g., analyzing ARP, DNS, or TCP traffic).
- Always sanitize IPs or hostnames when sharing captures publicly.
