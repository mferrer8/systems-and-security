# **04 – Web Vulnerability Testing (DVWA – XSS & SQL Injection)**

# **Target & Environment**

| Component           | Value                               |
| ------------------- | ----------------------------------- |
| Analyst Machine     | Ubuntu Desktop (Analyst VM)         |
| Target Host         | Metasploitable2                     |
| Web Applications    | DVWA (Damn Vulnerable Web App)      |
| DVWA Security Level | Low                                 |
| Services Targeted   | Reflected XSS, SQL Injection (SQLi) |

All testing was performed inside an isolated VirtualBox lab with no external connectivity.

---

# **1. Objective**

Perform hands-on testing of two foundational web vulnerabilities inside **DVWA**, document behavior, and understand how they appear from both an attacker and SOC perspective.

Vulnerabilities tested:

* Reflected Cross-Site Scripting (XSS)
* SQL Injection (SQLi)

All work was completed strictly for educational purposes in a controlled lab.

---

# **2. Vulnerabilities Overview**

## **2.1 Reflected Cross-Site Scripting (XSS)**

Occurs when user-controlled input is returned to the browser without sanitization and is executed as JavaScript.

Example behavior:

User input → rendered directly into page HTML.

If input contains script tags, the browser executes it.

---

## **2.2 SQL Injection (SQLi)**

Occurs when untrusted user input is concatenated directly into SQL queries.

Typical pattern in DVWA:

```
SELECT first_name, last_name FROM users WHERE id = '$id';
```

Without parameterized queries, attackers can manipulate the statement.

---

# **3. Exploitation Steps**

---

## **3.1 Reflected XSS**

### **3.1.1 Location**

```
DVWA → Vulnerabilities → XSS (Reflected)
```

### **3.1.2 Payload Used**

```
<script>alert('XSS test')</script>
```

### **3.1.3 Result**

A browser popup appeared, confirming script execution.

This verified that user input was returned unsanitized to the page.

---

## **3.2 SQL Injection**

### **3.2.1 Location**

```
DVWA → Vulnerabilities → SQL Injection
```

### **3.2.2 Payload Tested**

```
1' OR '1'='1
```

### **3.2.3 Result**

DVWA returned user data from the database instead of only one record, confirming successful SQL injection.

---

# **4. Evidence (Representative Examples)**

### **4.1 Reflected XSS Request**

```
GET /dvwa/vulnerabilities/xss_r/?name=<script>alert('XSS')</script>
```

Result: JavaScript executed in the browser context.

---

### **4.2 SQL Injection Request**

```
GET /dvwa/vulnerabilities/sqli/?id=1'+OR+'1'='1&Submit=Submit
```

Result: Multiple user records displayed.

---

# **5. Analysis**

| Component        | Result                                               |
| ---------------- | ---------------------------------------------------- |
| Attack Surface   | Input fields with no validation                      |
| Overall Risk     | High                                                 |
| Impact           | Session theft, data disclosure, authentication abuse |
| Detection Source | Web logs, WAF alerts, SIEM correlation rules         |

---

# **6. Impact Summary**

An attacker could:

* Execute untrusted JavaScript in victims’ browsers
* Extract sensitive user records from the database
* Bypass intended application logic
* Pivot to credential theft and session hijacking

These represent common patterns seen in real incident response work.

---

# **7. Remediation Recommendations**

* Sanitize and encode user input
* Implement Content Security Policy (CSP)
* Use prepared statements / parameterized queries
* Validate input server-side and client-side
* Disable verbose error messages
* Log and alert on suspicious request parameters

---

# **8. Conclusion**

This exercise demonstrated how small payloads can expose critical vulnerabilities:

* Reflected XSS executed arbitrary JavaScript
* SQL Injection allowed unintended database access

Capturing, observing, and documenting these behaviors directly strengthens SOC investigation skills and reinforces why secure coding practices matter.

---
