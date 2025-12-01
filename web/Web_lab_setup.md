# Small Web & Exploitation Lab Setup

This repository documents the virtual lab environment used for practicing web security testing, traffic interception, and exploitation fundamentals. The lab is intentionally isolated and configured for local use only.

---

## Lab Overview

The lab consists of two virtual machines running on VirtualBox:

### **1. Analyst Workstation (Ubuntu VM)**

Used for web testing, interception, analysis, and exploitation.

**Key Tools Installed**

* **Burp Suite Community Edition** (intercepting HTTP/S traffic)
* **Nmap** (network reconnaissance)
* **Firefox** (configured to route HTTP/S traffic through Burp)
* **Basic Linux utilities** for analysis and scripting

**Network Settings**

* **Static IP:** `10.0.0.10`
* **No external internet access** after setup (NAT disabled)
* Connected to an **Internal Network** for controlled testing

---

### **2. Metasploitable2 Target VM**

A deliberately vulnerable Linux machine used for web testing and exploitation practice.

**Static IP:** `10.0.0.20`
**Network Type:** Internal Network (same segment as analyst VM)

---

## Services & Applications (Metasploitable2)

The target machine hosts multiple intentionally vulnerable services commonly used for training and demonstrations.

### **Web Applications**

Accessible via browser from the analyst VM:

* `http://10.0.0.20/`

  * Apache 2.2.8 default page
  * TWiki
  * phpMyAdmin
  * Mutillidae
  * DVWA
  * WebDAV interface

* **Tomcat (Coyote JSP Engine)**

  * Running on: `http://10.0.0.20:8180/`
  * Apache Tomcat/Coyote JSP engine 1.1

---

### **Scanned Network Services**

From `nmap -sV 10.0.0.20`, the target exposes:

* **FTP** (vsftpd 2.3.4, ProFTPD 1.3.1 on 2121)
* **SSH** (OpenSSH 4.7p1)
* **Telnet**
* **SMTP** (Postfix)
* **DNS** (ISC BIND 9.4.2)
* **SMB** (Samba)
* **NFS**
* **MySQL 5.0.51a**
* **PostgreSQL 8.3.x**
* **VNC** and **X11**
* **IRC** (UnrealIRCd)
* **Java RMI registry**
* **Bind shell** on port 1524
  *(intentionally insecure)*

These services replicate a legacy, highly vulnerable environment ideal for controlled offensive testing.

---

## Network Isolation

To ensure safety:

* Both VMs are placed on an **isolated Internal Network**
* The analyst VM has **no route to the internet** once updates are complete
* The vulnerable VM is **never exposed to untrusted networks**

This keeps all traffic contained within the virtual lab.

---

## Repository Purpose

This README provides an overview of the environment used for:

* Web assessment practice
* Proxy interception
* Local exploitation testing
* Network discovery and enumeration

