# EDR – Endpoint Detection and Response

## Objective
Explain what Endpoint Detection and Response (EDR) is, why it is essential for SOC analysts, and how it is used for endpoint investigation and containment.

---

## Why EDR Matters in a SOC
SOC analysts frequently investigate activity at the **endpoint level**. While SIEM and Log Management provide visibility across systems, EDR allows analysts to inspect and respond to threats directly on individual devices.

EDR is critical for understanding:
- What is happening on a compromised host
- How malware behaves at runtime
- Whether other endpoints are affected

---

## What Is EDR?
Endpoint Detection and Response (EDR) is an endpoint security solution that provides:
- Continuous, real-time monitoring of endpoint activity
- Collection of detailed endpoint telemetry
- Automated detection and response capabilities

EDR enables analysts to detect, investigate, and contain threats directly on endpoint devices.

---

## Common EDR Solutions
- Carbon Black
- SentinelOne
- FireEye HX

(Let’s Defend provides a simulated EDR environment for training.)

---

## Endpoint Analysis with EDR

### Endpoint Visibility
EDR provides visibility into:
- Endpoint inventory
- Browser history
- Network connections
- Running processes

Analysts can:
- Search for specific hosts
- Perform IOC-based searches across all endpoints
- Pivot quickly between devices during investigations

---

## Live Investigation
Using EDR, analysts can:
- Connect directly to an endpoint
- Continue investigation on the affected machine
- Observe real-time behavior

This allows deeper inspection beyond logs alone.

---

## Containment and Isolation
When a device is confirmed or suspected to be compromised, it should be isolated from the network.

### Reasons for Isolation
- Prevent attacker lateral movement
- Stop command-and-control communication
- Limit further damage

EDR containment:
- Disconnects the device from internal and external networks
- Allows communication only with the EDR management system
- Enables continued investigation while minimizing risk

---

## Quick Tip: IOC-Based Searching
EDR allows analysts to search for indicators of compromise (IOCs) across all endpoints.

Example:
- File hash: `ac596d282e2f9b1501d66fce5a451f00`
- Search the hash in EDR
- Identify other affected hosts
- Determine attack scope

This step is critical for identifying widespread compromise.

---

## Analyst Best Practices
- Use EDR early during endpoint investigations
- Always search IOCs across all hosts
- Isolate compromised systems promptly
- Combine EDR findings with SIEM and Log Management data

---

## Key Takeaways
- EDR is used as frequently as Log Management in SOC investigations
- Endpoint visibility is essential for accurate incident response
- Proper use of EDR separates effective analysts from inexperienced ones
- Mastery of EDR significantly improves investigation speed and accuracy

---

## Next Steps
The next lesson introduces SOAR and how automation can accelerate SOC analysis and response workflows.
