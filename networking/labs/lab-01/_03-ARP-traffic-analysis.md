# Lab 03 — ARP Traffic Analysis

## Overview

In this lab, we analyzed **ARP traffic** on a small virtual network. The objectives were to:

* Capture and analyze ARP requests and replies
* Identify unusual ARP behavior (constant requests)
* Understand how devices announce themselves on a LAN
* Use `tcpdump` to capture and observe live traffic

**ARP Background:**  
The **Address Resolution Protocol (ARP)** maps IP addresses to MAC addresses. Every host maintains an ARP cache to reduce unnecessary network broadcasts. Common ARP traffic types:

* **ARP Request:** "Who has IP X? Tell IP Y"
* **ARP Reply:** "IP X is at MAC Z"

By analyzing ARP traffic, we can troubleshoot connectivity issues and observe host behavior in a LAN.

---

## Lab Setup

We used a **virtual network of three VMs**:

* **Analyst VM:** Captures and analyzes traffic
* **Target1 VM:** Linux VM (initial source of the ARP issue)
* **Target2 VM:** Linux VM

On the **Analyst VM**, we used **three terminals**:

1. **Terminal 1 — Capture ARP traffic to a `.pcap` file**  

   ```bash
   sudo tcpdump -i enp0s8 arp -vv -n -w ~/Desktop/networking/arp-capture_L03.pcap
````

* `-i enp0s8` → capture on the internal/NAT interface
* `arp` → filter only ARP traffic
* `-vv` → verbose output for detailed info
* `-n` → numeric IPs/MACs only
* `-w` → save captured traffic

2. **Terminal 2 — Live ARP traffic view**

   ```bash
   sudo tcpdump -i enp0s8 arp -vv -n
   ```

3. **Terminal 3 — Issue commands (pings) to trigger ARP requests**

   ```bash
   ping 10.0.0.y
   ping 10.0.0.z
   ```

This setup allows **simultaneous traffic generation, live monitoring, and recording**.

---

## Initial Observation — Constant ARP Requests

During initial captures, we observed **constant ARP requests flooding the network**:

```text
10:19:46.620748 ARP, Request who-has 10.0.0.y tell 10.0.0.x, length 46
10:19:47.644690 ARP, Request who-has 10.0.0.y tell 10.0.0.x, length 46
10:19:48.668623 ARP, Request who-has 10.0.0.y tell 10.0.0.x, length 46
```

*Repeated requests for `10.0.0.y` indicated a host was unable to resolve a MAC address.*

---

## Issue Diagnosis

By inspecting the **ARP headers**, we identified **Target1 VM (10.0.0.y)** as the source of the repeated requests.

**Root Cause:**
Target1 repeatedly tried to resolve the IP of the gateway (`10.0.0.1`) due to misconfigured DNS (`systemd-resolved`) or missing entries in `/etc/resolv.conf`. This caused constant ARP traffic.

---

## Resolution of ARP Flood

We applied a **clean solution for isolated lab environments**:

**✅ Solution — Disable systemd-resolved (best for isolated labs)**

```bash
sudo systemctl disable systemd-resolved --now
sudo rm /etc/resolv.conf
echo "nameserver 0.0.0.0" | sudo tee /etc/resolv.conf
```

*Effect:*

* Linux stops querying DNS
* No ARP spam to resolve unreachable gateway
* Network traffic becomes clean and predictable

**Pros:**

* Quiet, predictable lab traffic
* No background noise from unnecessary ARP requests
* Ideal for packet-level analysis

**Cons:**

* DNS resolution is disabled until re-enabled

After applying this, **ARP flood stopped**, and the network stabilized.

---

## Observing Normal ARP Behavior

### Target Announcements

When **Target2 VM** was powered on, it **announced itself** on the network:

```text
10:24:37.733506 ARP, Request who-has 10.0.0.z tell 0.0.0.0, length 46
10:24:37.787948 ARP, Request who-has 10.0.0.z tell 10.0.0.z, length 46
```

*New hosts broadcast to learn MAC addresses and introduce themselves.*

### ARP Requests Triggered by Ping

Using **Terminal 3**, we issued pings:

```bash
ping 10.0.0.y
ping 10.0.0.z
```

This generated ARP traffic only when a MAC address was unknown:

```text
10:25:08.341519 ARP, Request who-has 10.0.0.x tell 10.0.0.z, length 46
10:25:08.342846 ARP, Reply 10.0.0.x is-at aa:bb:cc:dd:ee:ff, length 46
```

*ARP requests are now **normal and expected** when initiating communication.*

---

## Comparison: Before vs After Resolution

**Before disabling systemd-resolved (ARP Flood):**

```text
10:19:46.620748 ARP, Request who-has 10.0.0.y tell 10.0.0.x, length 46
10:19:47.644690 ARP, Request who-has 10.0.0.y tell 10.0.0.x, length 46
10:19:48.668623 ARP, Request who-has 10.0.0.y tell 10.0.0.x, length 46
```

**After resolution (Normal ARP behavior):**

```text
10:25:08.341519 ARP, Request who-has 10.0.0.x tell 10.0.0.z, length 46
10:25:08.342846 ARP, Reply 10.0.0.x is-at aa:bb:cc:dd:ee:ff, length 46
```

*The network is now clean, and ARP requests are only sent when needed.*

---

## Observations & Analysis

* Initial ARP flood was due to Target1 VM repeatedly trying to resolve the gateway IP.
* Disabling `systemd-resolved` and clearing `/etc/resolv.conf` eliminated unnecessary ARP traffic.
* Powering on VMs triggers ARP announcements; pings generate ARP requests only when needed.
* ARP traffic can reveal device presence, MAC addresses, and connectivity issues on a LAN.

---

## Notes

* Always **sanitize IPs** before sharing captures.
* Use **separate terminals** for capture, live view, and command execution.
* Captured `.pcap` files can be used to correlate ARP with ICMP, DNS, and other network traffic for further analysis.

---
