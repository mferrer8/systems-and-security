# **02 — HTTP Traffic Analysis**

**Web Lab 01 — Ubuntu Analyst VM → Metasploitable2**

---

## **Overview**

This exercise introduces real HTTP traffic analysis using a controlled lab setup:

* **Analyst Machine:** Ubuntu Desktop (10.0.0.10)
* **Target:** Metasploitable2 (10.0.0.20)
* **Application:** DVWA (Damn Vulnerable Web Application)
* **DVWA Security Level:** **High** (verified from session cookie)

The purpose of the exercise is to observe and understand how login activity appears “on the wire,” and how to extract meaningful artifacts from raw HTTP packets.

---

## **1. Understanding HTTP in Practice**

When a user logs into a web application like DVWA, the browser sends an **HTTP POST request** containing:

* The URL being accessed
* Required headers (Host, User-Agent, Cookies, etc.)
* Form data (username + password)

Because DVWA is served over plain HTTP (not HTTPS), **all login data is transmitted in cleartext**, making it visible to anyone capturing traffic.

---

## **2. Packet Capture Setup**

Traffic was captured from the analyst VM using:

### **tcpdump**

```bash
sudo tcpdump -i enp0s3 -A host 10.0.0.20 and port 80 -w dvwa-login.pcap
```

### **Wireshark**

The PCAP was then opened in Wireshark, filtering for:

```
http.request.method == "POST"
```

A login attempt (`admin` / `password`) was performed at:

```
http://10.0.0.20/dvwa/login.php
```

---

## **3. Captured HTTP Login Request**

Below is the exact packet containing the DVWA login credentials:

```
POST /dvwa/login.php HTTP/1.1
Host: 10.0.0.20
User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:145.0) Gecko/20100101 Firefox/145.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Content-Type: application/x-www-form-urlencoded
Content-Length: 44
Origin: http://10.0.0.20
Connection: keep-alive
Referer: http://10.0.0.20/dvwa/login.php
Cookie: security=high; PHPSESSID=4c0deda42798101dc3ffa2be7ddfb93e
Upgrade-Insecure-Requests: 1

username=admin&password=password&Login=Login
```

---

## **4. Extracted Key Artifacts**

### **Request Method**

* **POST** — used when sending data (username/password)

### **Targeted Endpoint**

* `/dvwa/login.php`

### **Headers of Interest**

| Header                    | Meaning                         | Why It Matters                           |
| ------------------------- | ------------------------------- | ---------------------------------------- |
| **Host: 10.0.0.20**       | Target web server               | Confirms which system received the login |
| **User-Agent**            | Browser + OS info               | Useful for fingerprinting attackers      |
| **Cookie: security=high** | DVWA security mode              | Confirms app configuration               |
| **Cookie: PHPSESSID=…**   | Session identifier              | Tracks logged-in sessions                |
| **Referer: …/login.php**  | The page where login originated | Helps reconstruct user behavior          |

### **Form Data (Credentials – Cleartext)**

| Field    | Value      |
| -------- | ---------- |
| username | `admin`    |
| password | `password` |
| Login    | `Login`    |

These were transmitted **unencrypted**, making them visible to anyone capturing network traffic.

---

## **5. SOC-Relevant Observations**

### **1. Credentials Visible in Cleartext**

Because DVWA uses HTTP instead of HTTPS, login data appears plainly in the packet capture.
A real attacker could harvest credentials via MITM or passive sniffing.

### **2. Session Cookie Captured**

The `PHPSESSID` cookie can be used for:

* Session hijacking
* Replay attacks (if server does not validate IP/user-agent)

### **3. Security Level Confirmed**

The cookie `security=high` confirms DVWA mode, useful for correlating expected behaviors during testing.

### **4. Behavioral Indicators**

The request flow shows:

* Successful login attempt
* Use of a valid session token
* Normal browser-originated request (not an automated tool)

This helps analysts distinguish real users from attacks.

---
