# Chapter 2-12 – How to Run Excel Macros Created by OpenAI

**Status:** Completed  
**Focus:** Demonstration of ChatGPT generating an Excel macro that invokes a PowerShell script, and the associated safety/ethical concerns

---

## Summary
This video demonstrates that ChatGPT can be asked to generate Excel VBA macros that call external PowerShell scripts. The instructor shows that the model may initially refuse to produce such code for safety reasons, but can sometimes be persuaded by framing the request as a legitimate administrative task. The example highlights how easily automation features can be abused to deliver and run arbitrary code, and underscores the importance of strict safety controls and verification before ever running macros.

---

## Key Takeaways

**Model behavior and safety**
- Modern models may refuse to generate code that clearly appears malicious, but those safeguards are not absolute.  
- Claiming a legitimate use case can sometimes bypass initial refusals. Analysts should assume malicious actors can exploit this behavior.

**Risk demonstration**
- A macro that runs a PowerShell script can perform any action that the PowerShell payload contains (benign automation or malicious activity).  
- The instructor runs an example where the macro triggers a PowerShell script that opens a file — illustrating the execution pathway rather than demonstrating a real attack.

**Why this matters for SOC analysts**
- Macros remain a high-risk delivery vector for malware and post‑exploitation payloads.  
- Automated code generation tools lower the bar for attackers to create convincing or functional malware/malicious automation.  
- SOC teams must treat macro-enabled documents as high priority during triage and incident response.

---

## Safe Alternatives & Defensive Recommendations (non-actionable)
- Use ChatGPT for **analysis** and triage (e.g., explain what a provided macro appears to do) rather than for generating executable macros that invoke system commands.  
- Maintain an isolated sandbox or instrumented VM for any necessary dynamic analysis; do not execute untrusted macros on production systems.  
- Enforce endpoint policies that block or restrict Office macro execution by default (group policies, EDR controls).  
- Educate users and update phishing/malware playbooks to include macro-enabled documents as a common attack vector.  
- Preserve artifacts (original document, macro text, timestamps) and follow incident response procedures when a suspicious macro is found.

---

## Notes for SOC Analysts
- Treat any macro that invokes system commands (PowerShell, cmd, WScript, etc.) as potentially malicious until proven otherwise.  
- When using AI tools within your organization, enforce strict usage policies and content filters to prevent generation of risky automation.  
- Do not paste full, sensitive, or production macros into external AI services without redaction and appropriate approvals.

---

## How ChatGPT Has Changed (2025 Update)
- Newer models (GPT-5) include stronger safety filters and clearer refusal behaviors for requests that appear to enable code execution or malware.  
- However, model behavior can still be influenced by prompt framing; SOC teams should not rely solely on model refusals as a security control.  
- GPT-5 provides better guidance on safe analysis workflows (static analysis approaches, indicators to extract) and emphasizes non-execution methods for investigation.  
- Despite improvements, human oversight, sandboxing, and policy enforcement remain essential.

---

**End of Chapter 2-12**
