# Basic Network Commands

This document covers fundamental network commands every SOC Analyst should know.  
These commands are essential for verifying connectivity, diagnosing network issues, and validating alerts or indicators observed in security tools.

---

## 1. Viewing Network Configuration

### `ifconfig` (Linux/macOS) and `ip addr` (Linux)
These commands display the IP address, network interfaces, and connection details of a host.

#### Examples
```bash
ifconfig
or

bash
Copy code
ip addr show
Output Information
Interface name: eth0, wlan0, lo

IP address: Assigned to the interface

MAC address: Unique hardware identifier

Subnet mask & broadcast address: Define local network range

Link status: Indicates if the interface is up or down

SOC Relevance
Confirm which interfaces and IPs are active on a compromised host.

Identify rogue or secondary interfaces potentially used by attackers.

Verify network connectivity after containment or segmentation.

Cross-check internal IPs observed in alerts with the host’s configuration.

2. Testing Connectivity
ping
Sends ICMP Echo Request packets to a destination to check reachability and measure response time.

Examples
bash
Copy code
ping 8.8.8.8
ping -c 4 example.com
Key Options
-c — Number of packets to send (Linux)

-n — Numeric output only (Windows)

-t — Continuous ping until stopped (Windows)

SOC Relevance
Verify whether a host or service is reachable during an investigation.

Determine if packet loss indicates network disruption or DoS activity.

Detect if ICMP is being blocked — which can reveal restrictive firewall rules or evasion attempts.

Used to validate connectivity when analyzing alerts for failed connections or system downtime.

3. Tracing Network Paths
traceroute (Linux/macOS) and tracert (Windows)
These commands display the path packets take from the local system to a destination by listing each router (hop) along the route.

Examples
bash
Copy code
traceroute example.com
or

bash
Copy code
tracert example.com
Output Information
Each line represents a hop (router or gateway) between source and destination.

Shows IP address, hostname, and round-trip time (RTT) for each hop.

Asterisks (*) indicate a timeout or filtered hop.

SOC Relevance
Identify unusual routing paths that may indicate traffic redirection or MITM activity.

Verify whether traffic is leaving the expected network segment.

Detect potential exfiltration routes or compromised gateways.

Useful for confirming network segmentation effectiveness during containment.

4. Additional Useful Commands
Command	Description	SOC Application
nslookup example.com	Resolves a domain name to its IP address	Check if domains resolve to known malicious IPs
netstat -tuln or ss -tuln	Lists open ports and active connections	Identify suspicious listening services
arp -a	Displays ARP cache (IP-to-MAC mappings)	Detect ARP spoofing or unusual hosts on local network
route -n or ip route	Shows routing table	Verify default gateway or detect unauthorized routes

5. Key Takeaways
Basic network commands are essential for verifying host connectivity and network state during investigations.

Commands like ifconfig, ping, and traceroute provide valuable context for alerts, especially when correlating logs from firewalls or SIEMs.

Knowing these tools helps analysts distinguish between legitimate network issues and malicious activity.

