# **Week 6 Report – SOC Analyst Lab Progress**

This week was focused on getting my internal testing lab fully operational and running my first full round of reconnaissance and vulnerability scanning. Even though the holiday slowed things down, I was able to build out the environment, resolve network issues, and complete several important baseline tasks that I’ll build on over the next few weeks.

---

## **1. Lab Environment Setup**

I finished setting up a small, isolated lab inside VirtualBox using:

* **Ubuntu Analyst VM** – my main workstation for scanning, testing, and documentation
* **Metasploitable2** – the vulnerable target machine
* **Internal host-only network** – keeps all traffic contained so scans don’t leave the workstation

Most of the time was spent cleaning up networking: assigning static IPs, fixing DNS and routing issues, and making sure both machines could communicate without touching the outside internet. By the end, both systems were talking cleanly over the internal VLAN.

I also installed the main tools I’ll be using going forward:

* Nmap
* Burp Suite (Community Edition)
* Wireshark
* Extra Nmap scripts and scanning utilities

---

## **2. Repository & Documentation Work**

I updated my GitHub portfolio with a few new files that outline what I’ve done so far. This included:

* A simple **README** describing the lab layout
* A two-part **Network & Service Enumeration** write-up
* A quick **Burp Suite setup guide** to track how I configured it
* A few notes on my scanning workflow

The goal here was to keep everything organized so I can build on it as the weeks progress.

---

## **3. Full Nmap Vulnerability Scan**

After confirming connectivity, I ran my first in-depth Nmap scan against Metasploitable2. The command I used was:

```bash
sudo nmap -p- -sV --script "default,vuln,ssl-cert,ssl-enum-ciphers,http-*,auth" -oN vuln-scan.txt 10.0.0.20
```

This returned a huge amount of data, so I created a summary using grep to pull out meaningful sections. Several well-known vulnerabilities showed up, including:

* vsFTPd 2.3.4 backdoor
* SSL POODLE exposure
* Weak Diffie-Hellman configuration
* UnrealIRCd backdoor
* Slowloris/HTTP DoS potential
* Exposed Tomcat AJP and management services

These findings were added to the Week 6 documentation in a clean, readable format.

---

## **Overall Progress**

Even though the week was shorter than usual, it was still productive. I now have:

* A working and isolated analyst lab
* Verified communication between the systems
* A complete vulnerability scan with documented findings
* A structure in my GitHub repo for future reports
* A consistent reporting format to use going forward

Next week I’ll start capturing network traffic, analyzing HTTP requests, and moving into basic OWASP techniques like XSS and SQL injection.

---
