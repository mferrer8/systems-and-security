# **Week 5 – Network Fundamentals & Packet Analysis Report**

## Overview

Week 5 focused on applying networking fundamentals inside a controlled, isolated virtual environment. The primary goal was to capture, analyze, and interpret network traffic generated between three virtual machines while documenting findings in a SOC-style format. Although the full week plan was not fully completed, core practical milestones were achieved that demonstrate progressive growth in hands-on analysis, troubleshooting, and reporting.

---

## Lab Environment

A small virtual LAN was created consisting of:

* **Analyst VM (Linux)**
* **target1 (Linux mint)**
* **target2 (ubuntu)**

All systems were placed on the same internal VirtualBox network segment. No external internet routing or DNS resolution was enabled except when temporarily required to install updates.

On the analyst machine, three terminals were typically used:

1. Capturing traffic with `tcpdump` into `.pcap` files
2. Viewing real-time traffic
3. Generating traffic with commands such as `ping`, `dig`, or system configuration tools

This workflow closely simulates an entry-level SOC investigation environment.

---

## Topics Completed

### 1. ICMP Traffic Analysis

* Generated ICMP traffic using `ping` between machines.
* Captured traffic using `tcpdump` for offline review.
* Viewed both echo requests and echo replies in Wireshark.
* Observed how ICMP behaves in a small internal network with no gateway.

Key takeaways:

* ICMP is easy to generate and serves as a baseline connectivity test.
* ICMP confirms Layer 3 functionality in an isolated LAN.
* The presence or absence of replies quickly indicates routing or addressing issues.

---

### 2. DNS Traffic Analysis

* Performed DNS lookups using `dig`, `nslookup`, and `ping`.
* Identified DNS queries and responses in captured traffic.
* Observed common record types including:

  * `A`  (IPv4 address record)
  * `AAAA` (IPv6 address record)

Results:

* Demonstrated how name resolution appears at different OSI layers.
* Built familiarity with recognizing DNS transactions inside `.pcap` files.
* Reinforced understanding that many tools (including `ping`) perform DNS lookups before sending packets.

---

### 3. ARP Traffic Analysis and Troubleshooting

* Captured ARP broadcasts and replies occurring on startup and during ICMP testing.
* Noticed a high volume of ARP traffic from one system.
* Troubleshot the issue and identified the cause:

  * The system was continuously trying to reach a non-existent default gateway.
  * This resulted in repeated ARP requests.
* Removed the stale route to correct the issue.
* Confirmed normalized ARP behavior afterward.

Skills gained:

* Reading Layer 2 broadcast traffic.
* Recognizing abnormal patterns in packet captures.
* Diagnosing system networking configuration problems using packet evidence.

---

## Skills Developed

During Week 5, the following technical capabilities were strengthened:

* Capturing network data with `tcpdump`
* Opening and reviewing `.pcap` files in Wireshark
* Recognizing protocol behavior at Layer 2 and Layer 3
* Interpreting packet flow without relying on GUI tools
* Using network traffic patterns to:

  * Identify misconfiguration
  * Verify connectivity
  * Validate assumptions
* Writing professional, structured Markdown documentation suitable for publishing on GitHub

---

## Remaining Work

The original Week 5 plan included additional protocol investigation (such as basic TCP stream review) and more formal reporting. These tasks can be completed at the start of Week 6 without impacting the broader learning schedule.

---

## Conclusion

Week 5 provided meaningful hands-on understanding of what real analysts do: observe live traffic, capture data for review, diagnose network behavior, and document findings clearly. While not every planned task was completed, the week establishes a strong foundation for continued packet analysis, lab development, and SOC-style reporting in subsequent weeks.

---
