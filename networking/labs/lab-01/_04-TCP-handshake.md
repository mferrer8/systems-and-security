# Lab 01 — TCP Three-Way Handshake Capture

## Overview

In this lab task, we captured and analyzed a **TCP three-way handshake** initiated from the analyst host to an external web server. The objectives were to:

* Observe TCP connection establishment between a client and server
* Identify the **SYN**, **SYN/ACK**, and **ACK** packets
* Examine **sequence and acknowledgment numbers**
* Inspect TCP flags and understand basic TCP communication
* Use `.pcap` captures for packet-level analysis

**TCP Background:**
TCP is a connection-oriented protocol used for reliable communication. A TCP connection begins with a **three-way handshake**:

1. **SYN:** Client requests connection to server
2. **SYN/ACK:** Server acknowledges request
3. **ACK:** Client confirms receipt of server’s acknowledgment

Analyzing this handshake allows SOC analysts to verify connectivity, troubleshoot network issues, and detect unusual traffic patterns.

---

## Lab Setup

We used **three terminal windows** on the analyst VM:

1. **Terminal 1 — Capture TCP traffic to a `.pcap` file**

   ```bash
   sudo tcpdump -i enp0s8 -vv -n -w ~/Desktop/networking/tcp-handshake_L01.pcap
   ```

2. **Terminal 2 — Live view of TCP traffic**

   ```bash
   sudo tcpdump -i enp0s8 -vv -n
   ```

3. **Terminal 3 — Initiate TCP connection using curl**

   ```bash
   curl http://example.com
   ```

This workflow allows simultaneous **traffic generation**, **live monitoring**, and **recording for later analysis**.

---

## TCP Three-Way Handshake Diagram

```text
Analyst VM (Client)             Web Server (Server)
       |                               |
       | ----------- SYN ------------> |
       |                               |
       | <-------- SYN/ACK ----------- |
       |                               |
       | ----------- ACK ------------> |
       |                               |
Connection established, ready to send data
```

* **SYN:** Client requests connection
* **SYN/ACK:** Server acknowledges
* **ACK:** Client confirms receipt

---

## Live Traffic Example (Sanitized IPs)

```text
10.0.0.15.50000 > 192.168.1.10.80: Flags [S], seq 1000, win 64240, length 0
192.168.1.10.80 > 10.0.0.15.50000: Flags [S.], seq 2000, ack 1001, win 65535, length 0
10.0.0.15.50000 > 192.168.1.10.80: Flags [.], seq 1, ack 1, win 64240, length 0
```

**Subsequent HTTP Request:**

```text
10.0.0.15.50000 > 192.168.1.10.80: Flags [P.], seq 1:73, ack 1, length 73: HTTP GET / HTTP/1.1
192.168.1.10.80 > 10.0.0.15.50000: Flags [P.], seq 1:200, ack 74, length 200: HTTP 301 Moved Permanently
```

* `[S]`, `[S.]`, `[.]` indicate handshake control
* `[P.]` indicates data payload
* Observed connection termination with `[F.]` flags in later packets

---

## Observations & Analysis

* TCP connections follow the **three-way handshake pattern** before any data transfer.
* Sequence (`seq`) and acknowledgment (`ack`) numbers increment as expected.
* TCP flags `[S]`, `[S.]`, `[.]`, `[P.]`, `[F.]` indicate connection control, payload transmission, and connection termination.
* `.pcap` captures provide full details for post-capture analysis.
* Understanding the handshake is crucial for SOC analysts to **troubleshoot connectivity, detect SYN scans**, and analyze legitimate network traffic.

---
