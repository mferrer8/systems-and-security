# **PCAP Analysis Checklist**

*A reusable workflow for SOC, pentesting, and packet-level investigations.*

---

## **1. Initial Setup**

### **✔ Load the PCAP**

* Open in **Wireshark**
* Ensure timestamps and interface info look correct
* Apply an initial filter to remove noise:

```
!icmp && !arp
```

### **✔ Identify Key Hosts**

Gather:

* Analyst IP (your machine)
* Target IP (victim or web server)
* Any unexpected IPs

Identify direction of traffic:

* Outbound (requests)
* Inbound (responses)

---

## **2. Baseline Traffic Filtering**

### **✔ Filter by protocol**

Use essential filters:

```
http
tcp
udp
dns
ftp
ssh
smtp
```

### **✔ Filter by conversation**

To isolate communication with a target:

```
ip.addr == <target_ip>
```

### **✔ Filter for requests**

```
http.request
```

### **✔ Filter for responses**

```
http.response
```

---

## **3. HTTP Artifact Extraction**

### **✔ Extract Request Info**

For each HTTP request, capture:

* **Method**: GET, POST, HEAD
* **Request URI**
* **Host header**
* **User-Agent**
* **Referer**
* **Cookies sent by client**
* **Form parameters / POST body**

### **✔ Extract Response Info**

Record:

* **Status Code** (200, 302, 404, etc.)
* **Content-Type** (HTML, JSON, text)
* **Set-Cookie** headers
* **Redirects**
* **File/downloaded content**

---

## **4. Identify Sensitive Data**

### **✔ Look for cleartext credentials**

Filters:

```
http contains "username="
http contains "password="
```

or simply:

```
http.request.method == "POST"
```

Check:

* Login forms
* Reset forms
* Token exchanges

### **✔ Look for session tokens**

Search for:

* `PHPSESSID=`
* `JSESSIONID=`
* `token=`
* `auth=`
* `Bearer`

---

## **5. Security Findings**

### **✔ Unencrypted logins**

If credentials appear in packets:

* This is a major security issue
* Likely HTTP without TLS

### **✔ Session Hijacking Exposure**

If *Set-Cookie:* values appear:

* Determine if **HttpOnly**, **Secure**, **SameSite** attributes are missing
* Check reuse of captured session IDs

### **✔ Technology Fingerprinting**

From headers determine:

* Web server (Apache, Nginx, IIS)
* Scripting language (PHP, Python, Java)
* Framework versions

### **✔ Misconfigurations**

Look for:

* Internal IP leaks in headers
* Debug pages
* Verb tampering (PUT/DELETE allowed)
* Directory indexing

---

## **6. Suspicious Behavior Detection**

### **✔ Brute force indicators**

Look for:

* Repeated POSTs to login
* Increasing error codes (401, 403)

### **✔ SQL Injection**

Search for:

```
' OR 1=1 --
UNION SELECT
```

### **✔ Directory Traversal**

Search for:

```
../
%2e%2e/
```

### **✔ LFI/RFI**

Look for:

```
?page=
?file=
?template=
```

---

## **7. Traffic Flow Validation**

### **✔ Follow TCP Streams**

Right-click → “Follow TCP Stream”
Use this to reconstruct complete:

* Logins
* Web interactions
* File transfers
* Command injection results

### **✔ Identify anomalies**

Check for:

* Retransmissions
* Broken handshakes
* Reset packets
* Unusual timing

---

## **8. Final Notes for Reporting**

For each finding write:

### **Finding Summary**

* What was observed

### **Evidence Snippet**

Include:

* HTTP header lines
* Form data
* Session cookie extracted

### **Impact**

Explain risk (credential exposure, hijacking, enumeration, etc.)

### **Mitigation**

* Use HTTPS
* Harden cookie settings
* Patch application
* Block unnecessary services

---

## **9. Exporting Artifacts**

Save:

* Interesting packets as **Packet Bytes**
* Export objects → HTTP → files downloaded
* Save filtered PCAP for documentation

Organize:

```
/pcaps/
/screenshots/
/reports/
```

---
