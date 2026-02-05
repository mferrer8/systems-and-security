# SOAR – Security Orchestration, Automation, and Response

## Objective
Explain what SOAR is, how it integrates security tools, and how SOC analysts use automation and playbooks to improve investigation efficiency and consistency.

---

## What Is SOAR?
SOAR stands for **Security Orchestration, Automation, and Response**.

It enables multiple security tools and products within an environment to work together by automating repetitive tasks and standardizing investigation workflows.

Example:
- Automatically querying VirusTotal for a source IP from a SIEM alert
- Reducing manual workload for SOC analysts

---

## Common SOAR Platforms
- Splunk Phantom
- IBM Resilient
- Logsign
- Demisto

(Let’s Defend simulates SOAR functionality through its case management system.)

---

## Why SOAR Matters in a SOC

### Saves Time Through Automation
SOAR automates common investigation tasks, such as:
- IP address reputation checks
- File hash lookups
- Sandbox analysis of suspicious files

Automation allows analysts to focus on decision-making instead of repetitive actions.

---

### Centralization
SOAR provides a single platform where analysts can:
- Access multiple security tools
- Query third-party intelligence sources
- Correlate data without switching platforms

This improves efficiency and reduces context switching.

---

## Playbooks

Playbooks are predefined investigation workflows designed for specific alert types.

### Benefits of Playbooks
- Guide analysts step-by-step through investigations
- Reduce human error
- Ensure consistent analysis across the SOC team
- Standardize best practices

Example:
If all analysts must check IP reputation, the step is enforced through the playbook rather than relying on individual memory.

---

## SOAR in Let’s Defend
In Let’s Defend, **Case Management** functions as a SOAR platform.

- Alerts from the Monitoring page can be converted into cases
- Each case is assigned an automatic playbook
- Analysts investigate alerts by following the playbook steps
- Open and closed cases are tracked for visibility and accountability

---

## Analyst Best Practices
- Follow playbooks consistently
- Provide feedback when playbooks can be improved
- Use automation to reduce investigation time
- Focus on analysis and decision-making, not manual data gathering

---

## Key Takeaways
- SOAR increases SOC efficiency through automation and orchestration
- Playbooks ensure consistent and thorough investigations
- Centralized tooling improves analyst workflow
- Effective use of SOAR reduces alert fatigue and errors

---

## Next Steps
The next lesson focuses on **Threat Intelligence Feeds** and how external intelligence supports SOC investigations.
