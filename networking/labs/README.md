# Labs

The `/labs` directory contains hands-on networking exercises that reinforce theoretical concepts from the networking notes. Each lab is self-contained and includes setup steps, commands used, and verification tasks, designed for cybersecurity and SOC analysis practice.

## Lab 1: Basic Network Setup

**Objective:**
Build a small internal network of Linux-based VMs to understand static IP assignment, hostname mapping, service installation, and basic network traffic capture.

**Lab Overview:**

* Three VMs:

  * `analyst` — Ubuntu Desktop (tooling & scanning)
  * `target1` — Linux Mint (target)
  * `target2` — Ubuntu Desktop (target)
* Internal network setup with optional NAT adapter for temporary Internet access.
* Install essential services on targets (`ssh`, `apache2`).
* Configure `/etc/hosts` for hostname resolution across the lab.
* Capture and analyze network traffic using `tcpdump` and perform scans with `nmap`.

**Included Files:**

* `lab-notes.md` — Full setup walkthrough, commands executed, verification steps, and notes on capturing/analyzing traffic.
* `lab-checklist.md` — Step-by-step task tracker for replication or grading.

**Notes:**

* This lab is fully contained and isolated; no external network access is required except for optional updates.
* All VMs can be reverted to clean snapshots after setup for repeated practice.

---
