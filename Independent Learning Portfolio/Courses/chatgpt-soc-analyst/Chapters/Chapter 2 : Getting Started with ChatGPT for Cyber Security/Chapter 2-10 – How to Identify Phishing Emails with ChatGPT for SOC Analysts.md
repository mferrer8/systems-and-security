# Chapter 2-10 – How to Identify Phishing Emails with ChatGPT for SOC Analysts

**Status:** Completed  
**Focus:** Using ChatGPT to detect phishing indicators in email content and understanding risks of AI-generated phishing

---

## Summary
This video demonstrates how ChatGPT can analyze an email and highlight phishing indicators (suspicious sender domain, urgent call-to-action, generic greeting, obfuscated links, unusual date formats). It also shows how easily the model can generate convincing phishing emails, underscoring both its utility for detection and the risk that attackers can abuse the same capabilities.

---

## Key Takeaways

**Phishing Indicators ChatGPT Can Detect**
- Sender domain mismatches or domains not associated with the purported organization.  
- Requests for immediate action (click a link to “reactivate” or view a payment/bonus).  
- Generic greetings instead of personalized salutations.  
- Obfuscated or shortened links that may redirect to malicious hosts.  
- Strange formatting, unusual date/time formats, or poor spelling/grammar (often red flags).  
- Unexpected attachments or requests for credentials.

**Using ChatGPT to Analyze Emails**
- Paste the email text and ask for suspicious elements; ChatGPT will list likely indicators and explain why they are suspicious.  
- Ask for suggested triage steps (e.g., check sender SPF/DKIM/DMARC, inspect link targets in a sandbox, or validate with the sender via an alternate channel).  
- Use follow-up prompts to extract IOCs (URLs, domains, IPs) and produce safe detection queries for your SIEM.

**Risk: AI-Assisted Phishing**
- The same model can generate highly plausible phishing emails (subject lines, personalized body copy, logos/formatting guidance), which lowers the barrier for attackers.  
- Be aware of documented increases in automated, credential-phishing attempts linked to easy-to-use AI tools.

---

## Practical Prompts (Copy-Paste Ready)

- Analyze an email for phishing signs:
  > "Analyze this email and list all elements that appear suspicious or indicative of phishing. Provide a concise triage checklist and IOCs (URLs/domains) to extract. Email:\n\n`<paste email body and headers here>`"

- Extract IOCs without exposing sensitive content:
  > "Extract only URLs, domains, and email addresses from the following text; do not include message bodies or personal data. Text: `<paste here>`"

- Generate a safe detection query:
  > "Given these IOCs: `<list>`, provide an example SIEM query (Splunk or KQL) to detect logins or clicks to these domains in the last 24 hours."

- Ask for mitigation steps:
  > "List immediate containment actions and long-term mitigations for a confirmed credential-harvesting phishing campaign."

---

## Notes for SOC Analysts
- Never paste emails containing real user credentials, PII, or internal sensitive data into public AI services. Sanitize or redact sensitive fields before use.  
- Verify AI-identified indicators with technical checks: DNS/WHOIS, URL sandboxing, mail headers (SPF/DKIM/DMARC), and EDR telemetry.  
- Use ChatGPT outputs to accelerate triage (summaries, IOCs, suggested playbook steps), but always validate and apply institutional incident response procedures.  
- Consider adding AI-aware checks to phishing playbooks (e.g., look for AI-like phrasing or unusual personalization patterns).

---

## How ChatGPT Has Changed (2025 Update)
- GPT-5 provides more accurate and structured phishing analysis, better header parsing (SPF/DKIM hints), and clearer extraction of IOCs.  
- Newer models more often include safe-use reminders (do not paste credentials) and suggest non-destructive analysis steps (static URL checks, sandbox screenshots).  
- AI improvements have made generated phishing messages more polished; detection must rely more on technical signals (mail auth, link behavior) and user training rather than content-style alone.  
- Despite improved detection assistance, human validation and tooling remain critical to avoid false positives and prevent accidental data exposure.

---

**End of Chapter 2-10**
