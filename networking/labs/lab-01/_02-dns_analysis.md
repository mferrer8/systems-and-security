# Lab 01 — 02 DNS Traffic Analysis

## Overview

In this lab, we analyzed DNS traffic generated from the analyst host using `dig`, `nslookup`, and `ping`. The objectives were to:

* Capture and analyze DNS requests and responses
* Observe differences between `dig` and `nslookup` queries
* Understand DNS record types (`A` and `AAAA`)
* Record and analyze traffic in a `.pcap` file using `tcpdump`

**DNS Background:**
The Domain Name System (DNS) translates human-readable hostnames into IP addresses. DNS query types include:

* **A (Address) Record:** Maps a hostname to an IPv4 address.
* **AAAA (Quad-A) Record:** Maps a hostname to an IPv6 address.

By analyzing DNS traffic, we can learn which IPs a host is communicating with, verify correct resolution, and detect unusual or suspicious queries.

---

## Lab Setup

We used **three terminal windows** to organize the workflow:

1. **Terminal 1 — Capture DNS traffic to a `.pcap` file**

   ```bash
   sudo tcpdump -i enp0s8 port 53 -vv -n -w ~/Desktop/networking/dns-capture_L01.pcap
   ```

   * `-i enp0s8` → capture packets on the NAT/internal interface
   * `port 53` → filter DNS traffic
   * `-vv` → verbose output for detailed packet information
   * `-n` → disable DNS resolution for cleaner display
   * `-w` → save captured traffic to `.pcap` for Wireshark

2. **Terminal 2 — Live view of DNS traffic**

   ```bash
   sudo tcpdump -i enp0s8 port 53 -vv -n
   ```

   * Displays DNS requests and responses in real-time

3. **Terminal 3 — Generate DNS queries**

   * Using `dig`:

     ```bash
     dig google.com
     ```

   * Using `nslookup`:

     ```bash
     nslookup google.com
     ```

   * Using `ping` (triggers reverse DNS lookups):

     ```bash
     ping google.com
     ```

This setup allows simultaneous traffic generation, live monitoring, and recording for later analysis.

---

## Example DNS Queries and Capture

### `dig` Command

```bash
; <<>> DiG 9.18.39-Ubuntu <<>> google.com
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 34659
;; QUESTION SECTION:
;google.com.	IN	A

;; ANSWER SECTION:
google.com.	12	IN	A	142.250.115.102
google.com.	12	IN	A	142.250.115.101
google.com.	12	IN	A	142.250.115.100
google.com.	12	IN	A	142.250.115.139
google.com.	12	IN	A	142.250.115.113
google.com.	12	IN	A	142.250.115.138
```

**Live `tcpdump` Output (dig)**

```text
12:03:08.548542 IP 10.0.3.15.55736 > 172.16.10.13.53: A? google.com
12:03:08.566312 IP 172.16.10.13.53 > 10.0.3.15.55736: A 142.250.115.102, 142.250.115.101, ...
```

---

### `nslookup` Command

```bash
Server: 127.0.0.53
Address: 127.0.0.53#53

Non-authoritative answer:
Name: google.com
Address: 142.250.115.100
Address: 142.250.115.139
Address: 142.250.115.101
Address: 142.250.115.102
Address: 142.250.115.138
Address: 142.250.115.113
Address: 2607:f8b0:4023:1004::65
Address: 2607:f8b0:4023:1004::8b
```

**Live `tcpdump` Output (nslookup)**

```text
12:04:22.300284 IP 10.0.3.15.56583 > 172.16.10.13.53: A? google.com
12:04:22.323527 IP 172.16.10.13.53 > 10.0.3.15.56583: A 142.250.115.100, ...
12:04:22.325602 IP 10.0.3.15.46818 > 172.16.10.13.53: AAAA? google.com
12:04:22.342559 IP 172.16.10.13.53 > 10.0.3.15.46818: AAAA 2607:f8b0:4023:1004::65, ...
```

---

### `ping` Command (Reverse DNS Lookup)

```bash
PING google.com (142.250.115.113) 56(84) bytes of data.
64 bytes from rq-in-f113.1e100.net (142.250.115.113): icmp_seq=1 ttl=105 time=14.6 ms
64 bytes from rq-in-f113.1e100.net (142.250.115.113): icmp_seq=2 ttl=105 time=13.9 ms
```

**Live `tcpdump` Output (ping-induced DNS)**

```text
12:06:09.590059 IP 10.0.3.15.59678 > 172.16.10.13.53: PTR? 113.115.250.142.in-addr.arpa
12:06:09.603466 IP 172.16.10.13.53 > 10.0.3.15.59678: PTR rq-in-f113.1e100.net
12:06:11.599186 IP 10.0.3.15.56125 > 172.16.10.13.53: A? connectivity-check.ubuntu.com
12:06:11.613081 IP 172.16.10.13.53 > 10.0.3.15.56125: A 91.189.91.48, ...
```

---

## Observations & Analysis

* DNS queries for `dig` and `nslookup` appear as **UDP packets on port 53**.
* `dig` typically requests only **A records**, whereas `nslookup` may request both **A and AAAA records**.
* `ping` triggers **PTR queries** for reverse DNS lookups.
* Observing packet details helps us see:

  * Which hostnames are being resolved
  * Corresponding IP addresses (both IPv4 and IPv6)
  * DNS server responses and potential resolution issues
* Analyzing DNS can uncover:

  * Misconfigured or unreachable hosts
  * Unexpected queries that may indicate malware or misbehaving applications
  * Traffic patterns for network troubleshooting

---

## Notes

* Always sanitize IPs when sharing captures publicly.
* Use separate terminals for **capture**, **live view**, and **command execution** for clarity.
* Captured `.pcap` files can be used for later labs, such as correlating DNS with ICMP, ARP, or TCP traffic.
* Understanding DNS query types and packet flow is fundamental for SOC analysts when investigating network activity.

---
