# Week 4 – Networking Fundamentals & Lab Setup Report

## Overview

Week 4 focused on establishing core networking skills, building a functioning virtual lab environment, and beginning the transition from basic command-line networking into real packet analysis workflows.

---

## Key Accomplishments

### 1. Virtual SOC Lab Environment Built

A small, isolated virtual environment was created consisting of:

* **Analyst Machine (Kali or Ubuntu)**
* **Target Machine 1 (Linux)**
* **Target Machine 2 (Windows or Linux)**

All VMs were placed on the same internal network, providing a safe sandbox for analysis and experimentation without external internet access.

---

### 2. Installed & Configured Core Analysis Tools

On the analyst machine:

* Wireshark installed for GUI packet analysis
* `tcpdump` installed for terminal-based captures
* Multiple terminals configured to mimic real SOC workflow:

  * One terminal capturing live packets
  * One terminal running network tests (ping, traceroute, etc.)
  * One terminal for note-taking or scripting

This setup mirrors a real-world analyst workstation.

---

### 3. Validated Network Connectivity

Connectivity between machines was tested and verified using:

* `ping`
* ARP broadcasts
* Packet captures viewed in Wireshark and tcpdump

This confirmed:

* VMs were on the same subnet
* Traffic was flowing correctly
* The lab environment was functional

---

### 4. Practiced Command-Line Networking Tools

The analyst machine was used to review essential commands such as:

* `ifconfig` / `ip addr`
* `ping`
* `netstat`
* `traceroute`

Notes were taken for reference as a growing knowledge base.

---

### 5. Bash Scripting Progress

Several automation scripts were developed:

#### `greet.sh`

* Greets the user by name
* Demonstrates variables and user input

#### `ping-sweep.sh`

* Loops through multiple hosts
* Automates connectivity checks
* Uses return codes to determine success or failure

#### `file-check.sh`

* Introduced `if/else` tests
* Checks if a file exists before operating on it

These scripts reflect early SOC automation and shell competency.

---

### 6. Preparation for Packet Analysis

With the lab configured and scripts working, initial `.pcap` files were captured for:

* ICMP traffic
* ARP broadcasts
* Host-to-host communication

Initial planning was done for:

* Sanitizing captures before uploading to GitHub
* Writing professional SOC-style analysis reports

---

## Skills Strengthened This Week

* Understanding TCP/IP and OSI fundamentals
* Using core network commands confidently
* Managing and interacting with multiple VMs
* Beginning automation with Bash
* Validating network flow using real tools
* Building toward structured network traffic analysis

---

## TL;DR

Week 4 successfully established the foundation needed for real SOC traffic analysis by:

✔ Building the lab
✔ Installing analysis tools
✔ Validating network traffic
✔ Practicing networking commands
✔ Starting Bash automation
✔ Beginning packet capture workflows

The environment is now stable and ready for deeper network analysis in Week 5.
