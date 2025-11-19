# Local Network Survey

A quick hands-on practice of essential networking commands used to gather and understand local and external network information. Results below are sanitized to avoid real network details.

---

## 🔹 Commands Covered

* `ping`
* `ipconfig` / `ip addr`
* `nslookup`
* `dig`
* `tracert` / `traceroute`

---

# 1. ping

Tests reachability and round-trip time to a remote host.

### Command:

```
ping -n 2 google.com
```

### Sample Output (Sanitized)

```
Pinging google.com [142.250.XXX.XXX] with 32 bytes of data:
Reply from 142.250.XXX.XXX: bytes=32 time=14ms TTL=106
Reply from 142.250.XXX.XXX: bytes=32 time=13ms TTL=106

Ping statistics:
    Packets: Sent = 2, Received = 2, Lost = 0
Approximate round trip time:
    Minimum = 13ms, Maximum = 15ms, Average = 14ms
```

### Notes

* `-n <count>` (Windows) sets number of packets to send.

---

# 2. ipconfig (Windows)

Displays NIC configuration including IP, subnet, and gateway.

### Command:

```
ipconfig
```

### Sample Output (Sanitized)

```
Windows IP Configuration

Wireless LAN adapter Wi-Fi:
   IPv4 Address. . . . . . . . . : 192.168.1.77
   Subnet Mask . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . : 192.168.1.254
```

---

# 3. ip addr (Linux)

Shows IP addresses, interface state, MAC addresses, etc.

### Command:

```
ip addr
```

### Sample Output (Sanitized)

```
2: eth0: <UP,BROADCAST,RUNNING> mtu 1500
    link/ether aa:bb:cc:dd:ee:ff
    inet 10.0.0.10/24 brd 10.0.0.255 scope global eth0
```

---

# 4. nslookup

Queries DNS and shows the DNS server used.

### Command:

```
nslookup google.com
```

### Sample Output (Sanitized)

```
Server: 127.0.0.53
Address: 127.0.0.53#53

Non-authoritative answer:
Name: google.com
Addresses:
  142.250.115.138
  142.250.115.113
  142.250.115.139
```

---

# 5. dig (Linux)

Provides detailed DNS lookup results.

### Command:

```
dig google.com
```

### Sample Output (Sanitized)

```
;; QUESTION SECTION:
;google.com.      IN A

;; ANSWER SECTION:
google.com. 230 IN A 142.250.115.102
google.com. 230 IN A 142.250.115.113

;; SERVER: 127.0.0.53#53
;; Query time: 2 msec
```

---

# 6. tracert (Windows) / traceroute (Linux)

Shows the path taken across routers to reach a destination.

### Command (Windows):

```
tracert google.com
```

### Sample Output (Sanitized)

```
Tracing route to google.com [142.250.115.101]

 1     1 ms    1 ms    1 ms   192.168.1.254
 2     3 ms    2 ms    2 ms   ISP-Router
 3     6 ms    6 ms    5 ms   Carrier-Network
 ...
12    14 ms   14 ms   15 ms   google-edge-node
```

---

# Summary of Findings

| Item            | Value (Sanitized)                              |
| --------------- | ---------------------------------------------- |
| Local IP        | `192.168.1.77`                                 |
| Subnet Mask     | `255.255.255.0`                                |
| Default Gateway | `192.168.1.254`                                |
| Public IP       | Retrieved via external lookup (not shown here) |
| DNS Server      | `127.0.0.53` (local resolver stub)             |

---

# Key Takeaways

* `ping` verifies basic connectivity and latency.
* `ipconfig` / `ip addr` reveal local network configuration.
* `nslookup` and `dig` show DNS resolution details.
* `tracert` / `traceroute` visualize packet path through the network.
* Together, these tools help understand and troubleshoot network behavior from local system outward.
