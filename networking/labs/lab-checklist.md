# lab-checklist.md

## Lab 1: Basic Network Setup Checklist

Use this checklist to confirm that the lab is fully configured. Replace placeholders as needed.

### VM and Network Configuration

* [ ] Adapter 1: Internal Network `intnet` attached to all VMs
* [ ] Optional Adapter 2: NAT on analyst VM for temporary updates
* [ ] Hostnames set:

  * [ ] `analyst`
  * [ ] `target1`
  * [ ] `target2`
* [ ] Static IPs applied via Netplan
* [ ] `/etc/hosts` updated on all VMs and backed up

### Services

* [ ] Targets:

  * [ ] `openssh-server` installed and running
  * [ ] `apache2` installed and running
* [ ] Analyst:

  * [ ] `nmap`, `tcpdump`, `wireshark` installed
  * [ ] `~/lab-results` directory created and secured

### Connectivity Tests

* [ ] `ip a` shows correct static address
* [ ] `ping target1` and `ping target2` succeed from analyst
* [ ] `nmap -sn target1 target2` discovers hosts

### Capture & Scan Examples

* [ ] `tcpdump` captures saved in `~/lab-results`
* [ ] `nmap` scans saved using `-oA` in `~/lab-results`
* [ ] Wireshark inspection of pcap files performed

### Snapshots

* [ ] Analyst VM snapshot: `lab-clean-analyst`
* [ ] Target1 snapshot: `lab-clean-target1`
* [ ] Target2 snapshot: `lab-clean-target2`

### Optional

* [ ] NAT adapter removed after updates
* [ ] SSH key auth configured between analyst and targets
* [ ] Log collection/SIEM forwarding configured (optional)
