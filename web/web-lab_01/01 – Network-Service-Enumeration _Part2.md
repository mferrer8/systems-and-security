# **01 – Network Service Enumeration (Part 2)**

## **Target:** 10.0.0.20

## **Tool:** Nmap

## **Date:** *[insert your date]*

---

## **1. Nmap Command Executed**

```bash
sudo nmap -p- -sV --script "default,vuln,ssl-cert,ssl-enum-ciphers,http-*,auth" -oN vuln-scan.txt 10.0.0.20
```

### **What This Command Does**

* **-p-** → Scans all 65,535 TCP ports
* **-sV** → Performs service & version detection
* **--script “default,vuln,ssl-cert,ssl-enum-ciphers,http-*,auth”**

  * Runs default scripts
  * Runs all vulnerability scripts
  * Enumerates SSL/TLS configuration
  * Runs all HTTP-related NSE scripts
  * Runs authentication-related scripts
* **-oN vuln-scan.txt** → Saves results to a file

---

## **2. High-Level Scan Summary**

The scan identified numerous exposed services across a wide attack surface including FTP, SSH, Telnet, SMTP, HTTP, RPC, SMB, MySQL, PostgreSQL, VNC, Java RMI, and more.

Multiple services were found vulnerable to **known exploitable CVEs**, **misconfigurations**, and **insecure protocols**.

---

## **3. Confirmed Vulnerabilities (From Nmap Script Output)**

Below are the **key confirmed findings** extracted from the scan.
(Each includes a short snippet from your summary output.)

---

### ### 🔥 **FTP (vsftpd 2.3.4) — Backdoor Vulnerability**

**Port:** 21/tcp
**Severity:** Critical
**CVE:** CVE-2011-2523
**Proof (snippet):**

```
VULNERABLE: vsFTPd version 2.3.4 backdoor
State: VULNERABLE (Exploitable)
IDs: CVE-2011-2523
```

This vulnerability allows attackers to gain a remote root shell by triggering a backdoored build of vsftpd.

---

### 🔥 **SSL POODLE Vulnerability**

**Ports:** Services using SSL
**Severity:** High
**CVE:** CVE-2014-3566
**Proof:**

```
VULNERABLE: SSL POODLE information leak
State: VULNERABLE
IDs: CVE-2014-3566
```

This allows a MITM attacker to decrypt encrypted SSL 3.0 traffic.

---

### 🔥 **TLS Diffie-Hellman Weak Parameters**

**Ports:** Services supporting DH key exchange
**Severity:** High
**CVE:** CVE-2015-4000 (Logjam)
**Proof:**

```
VULNERABLE: Anonymous Diffie-Hellman Key Exchange
State: VULNERABLE
IDs: CVE-2015-4000
```

Weak DH groups allow downgrade attacks and session compromise.

---

### 🔥 **Apache HTTP Slowloris DoS**

**Ports:** 80/tcp & 8180/tcp
**Severity:** Medium–High
**CVE:** CVE-2007-6750
**Proof:**

```
VULNERABLE: Slowloris DOS attack
State: LIKELY VULNERABLE
IDs: CVE-2007-6750
```

Slowloris can exhaust concurrent HTTP connections and deny service.

---

### 🔥 **Java RMI Registry Remote Code Execution**

**Port:** 1099/tcp
**Severity:** Critical
**Proof:**

```
VULNERABLE: RMI registry default configuration RCE
Default configuration allows loading classes from remote URLs.
```

This allows remote loading of attacker-controlled Java classes.

---

### 🔥 **PostgreSQL SSL CCS Injection**

**Port:** 5432/tcp
**Severity:** High
**CVE:** CVE-2014-0224
**Proof:**

```
VULNERABLE: SSL/TLS MITM vulnerability (CCS Injection)
Risk factor: High
IDs: CVE-2014-0224
```

This vulnerability allows session hijacking and plaintext recovery.

---

### 🔥 **UnrealIRCd Backdoor**

**Port:** 6667/tcp
**Severity:** Critical
**Proof:**

```
irc-unrealircd-backdoor: Looks like trojaned version of unrealircd.
```

Backdoored builds allow instant remote system compromise.

---

## **4. Insecure or Legacy Services Detected**

These services are not inherently vulnerable but carry high attack risk:

* **Telnet (23/tcp)** — cleartext authentication
* **rsh / rlogin / rexec (512–514/tcp)** — legacy, no encryption
* **X11 (6000/tcp)** — remote GUI protocol with weak access controls
* **VNC (5900/tcp)** — may allow unauthenticated screen access

---

## **5. Summary of Risk Exposure**

The host shows:

* Multiple **remote code execution** vulnerabilities
* Multiple **MITM & cryptographic weaknesses**
* Wide exposure of **unencrypted legacy services**
* Several **misconfigurations and known exploitable versions**

Overall, the system is **high risk** and should be considered compromised by design (Metasploitable-like).
