# **03 — Web Enumeration & Fingerprinting**

**Target:** Metasploitable2 (`10.0.0.20`)
**Analyst VM:** Ubuntu Desktop (`10.0.0.10`)

---

# **1. Objective**

The goal of this exercise is to enumerate the web services running on the Metasploitable2 machine by fingerprinting the server, identifying technologies in use, discovering files and directories, and locating potential vulnerabilities.

Tools used:

* **Nmap** (`http-*` NSE scripts)
* **WhatWeb**
* **Wappalyzer**
* **Nikto**

Each tool provides a different angle of visibility. Combined, they build a full picture of how insecure a target web application is.

---

# **2. Tools Used & What They Do**

## **2.1 Nmap (HTTP Script Scans)**

Nmap is a network scanner that can identify open ports and service versions.
The `http-*` scripts dig deeper into:

* HTTP headers
* Server info
* Enabled HTTP methods
* Directory structure
* Potential vulnerabilities
* Virtual hosts
* Authentication settings
* WebDAV support

### **Command Used**

```bash
sudo nmap -p 80 --script http-* 10.0.0.20 -oN day2-http-scripts.txt
```

### **Purpose**

This gives a broad enumeration of the HTTP service

---

## **2.2 WhatWeb**

WhatWeb is a web technology fingerprinting tool.
It identifies:

* Server type
* Programming languages
* Web frameworks
* Plugins or modules
* Application versions

### **Command Used**

```bash
whatweb http://10.0.0.20
```

---

## **2.3 Wappalyzer (Browser Plugin)**

A graphical technology-detection tool inside the browser.
It identifies:

* Server type
* Programming language
* CMS
* Frameworks
* Client-side libraries

Wappalyzer provides an easy view of the core components powering a site.

---

## **2.4 Nikto**

Nikto is a comprehensive web server vulnerability scanner.
It checks for:

* Outdated software
* Dangerous scripts
* Misconfigurations
* Directory indexing
* Insecure HTTP methods
* Default files
* phpinfo exposure
* Known vulnerabilities

### **Command Used**

```bash
nikto -h http://10.0.0.20 -o day2-nikto.html -Format htm
```

---

# **3. Results & Interpretation**

Below is a breakdown of the actual output and what each part means.

---

# **3.1 Nmap (http-* scripts)**

### **Key Findings**

#### **Server & Headers**

```
Server: Apache/2.2.8 (Ubuntu) DAV/2
X-Powered-By: PHP/5.2.4-2ubuntu5.10
Content-Type: text/html
```

**Interpretation:**

* Very old Apache version (2008-era)
* Running PHP 5.2 — end-of-life, full of vulnerabilities
* WebDAV (DAV/2) enabled → frequently misconfigured & dangerous

---

#### **Supported HTTP Methods**

```
Supported Methods: GET HEAD POST OPTIONS
```

**Interpretation:**
Normal for a web server, but still useful to know for future exploitation.

---

#### **Directory Structure (via http-sitemap-generator)**

Nmap enumerated important directories:

```
/dvwa/
/mutillidae/
/phpMyAdmin/
/twiki/
/dav/
/icons/
/dvwa/dvwa/images/
/dvwa/dvwa/css/
```

**Interpretation:**

These reveal multiple intentionally vulnerable applications:

* **DVWA**
* **Mutillidae**
* **phpMyAdmin**
* **TWiki**

These will be major targets later in your lab.

---

#### **Virtual Hosts**

```
http-vhosts: 128 names had status 200
```

**Interpretation:**
The server responds with HTTP 200 for many non-existent domain names.
This suggests the host has a wildcard configuration or simply ignores Host headers—common on old systems.

---

#### **XSS & CSRF Scripts**

Most came back with “couldn’t find” or “script failed.”
This is normal for very old web servers when scripts rely on modern responses.

---

# **3.2 WhatWeb Results**

```
Apache[2.2.8]
PHP[5.2.4-2ubuntu5.10]
WebDAV[2]
Title[Metasploitable2 - Linux]
HTTPServer[Ubuntu Linux]
```

**Interpretation:**
WhatWeb confirmed:

* Very outdated Apache
* Very outdated PHP
* WebDAV is active
* The server is clearly running Ubuntu

This lines up exactly with Nmap’s findings, giving confidence in fingerprint accuracy.

---

# **3.3 Wappalyzer Results**

```
Web server: Apache HTTP Server 2.2.8
Programming languages: PHP 5.2.4
OS: Ubuntu
Web server extensions: mod_dav 2
```

**Interpretation:**
Matches WhatWeb exactly.
Wappalyzer is useful for double-confirming technology stacks in a visual way.

---

# **3.4 Nikto Vulnerability Scan**

### **Major Findings**

#### **Outdated server software**

```
Apache/2.2.8 appears to be outdated
```

Severely outdated → hundreds of CVEs.

---

#### **Missing security headers**

```
X-Frame-Options header is not present.
```

Allows clickjacking attacks.

---

#### **Dangerous HTTP Methods**

```
DEBUG HTTP verb may show debugging information
TRACE method is active (vulnerable to XST)
```

TRACE enables Cross-Site Tracing attacks.

---

#### **Information Exposure**

```
/phpinfo.php exposes PHP configuration
```

This leaks:

* PHP version
* Server modules
* Loaded extensions
* Environment variables

---

#### **Directory Indexing Enabled**

```
/doc/
/test/
/icons/
```

Any attacker can list and download files.

---

#### **phpMyAdmin exposed**

```
/phpMyAdmin/
```

This should be restricted—has known brute-force & SQL injection attack paths.

---

#### **ETag inode leak**

```
inode: 412190
```

Location disclosure is rarely critical but useful for OSINT.

---

# **4. Consolidated Findings**

## **4.1 Server Stack**

* **Apache 2.2.8**
* **PHP 5.2.4**
* **Ubuntu Linux**
* **WebDAV (mod_dav) Enabled**

---

## **4.2 Interesting Directories**

* `/dvwa/`
* `/mutillidae/`
* `/phpMyAdmin/`
* `/webdav/`
* `/twiki/`
* `/icons/`
* `/test/`
* `/doc/`
* `/phpinfo.php`

---

## **4.3 Vulnerabilities Identified**

* Outdated Apache
* Outdated PHP
* Missing security headers
* Directory indexing
* TRACE enabled
* phpMyAdmin exposed
* phpinfo exposed
* Potential debug methods enabled
* WebDAV enabled (likely misconfigured)

---

# **5. Conclusion**

In this exercise, we used four complementary web enumeration tools to build a full picture of the Metasploitable2 web server. All tools consistently revealed a severely outdated and insecure environment running several intentionally vulnerable web applications. These results establish the attack surface for future labs involving exploitation, traffic analysis, and SOC-style monitoring.

---
