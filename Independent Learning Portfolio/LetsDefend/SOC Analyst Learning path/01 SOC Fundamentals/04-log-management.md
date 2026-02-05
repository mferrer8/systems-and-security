# Log Management

## Objective
Explain what Log Management is, why it is critical for SOC operations, and how SOC analysts use centralized logs during investigations.

---

## Why Log Management Matters
SOC analysts perform log analysis constantly. While different organizations use different products, the most important skill is knowing:
- **What logs to look for**
- **Where to find them**
- **How to query them efficiently**

Log Management systems reduce investigation time and minimize errors by centralizing log data.

---

## What Is Log Management?
Log Management is a centralized solution that collects and stores logs from multiple sources, such as:
- Web servers
- Operating systems
- Firewalls
- Proxies
- Email systems
- EDR solutions

All logs can be searched and analyzed from a single platform.

---

## Benefits of Centralized Logging
Without centralized log access:
- Analysts must query each device individually
- Investigations take longer
- The chance of missing critical data increases

With Log Management:
- One query can search across multiple log sources
- Analysts gain faster visibility into events
- Investigation efficiency improves significantly

---

## Log Management in Let’s Defend
In the Let’s Defend platform, log sources are categorized by **Type** (e.g., Proxy, Exchange, Firewall).

This indicates that:
- Logs from different systems are collected in one place
- Analysts can query multiple sources simultaneously
- Results are normalized for easier analysis

---

## Purpose of Log Management for SOC Analysts

### Use Case 1: Malware Command & Control Detection
If malware analysis reveals communication with a domain (e.g., `letsdefend.io`):
- Search the domain in Log Management
- Identify any internal devices communicating with the C2 server
- Determine scope of compromise

---

### Use Case 2: Lateral or Additional Compromise Detection
Scenario:
- SIEM alert shows one host exfiltrating data to `122[.]194[.]229[.]59`
- The affected host is isolated and remediated

Next step:
- Search the suspicious IP in Log Management
- Identify any other devices communicating with the same IP
- Detect activity not flagged by SIEM alerts

---

## Analyst Responsibilities with Log Management
- Validate SIEM alerts with raw log data
- Identify additional affected systems
- Investigate suspicious IPs, domains, and URLs
- Reduce blind spots in detection coverage

---

## Key Takeaways
- Log Management is essential for accurate SOC investigations
- Centralized logs reduce response time and error rates
- Analysts should always search logs beyond what SIEM alerts show
- Log Management helps uncover hidden or missed activity

---

## Next Steps
Future lessons will build on log analysis by introducing endpoint-level visibility and response using EDR solutions.
