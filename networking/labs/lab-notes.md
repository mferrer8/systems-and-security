# lab-notes.md

## Lab 1: Basic Network Setup

**Overview:**
This lab creates a small internal network with three Linux-based VMs for SOC-relevant networking practice.

**VMs:**

* `analyst` — Ubuntu Desktop (tooling & scanning)
* `target1` — Linux Mint (target)
* `target2` — Ubuntu Desktop (target)

**Key Tasks:**

1. Set hostnames.
2. Configure static IP addresses using Netplan.
3. Update `/etc/hosts` for hostname resolution.
4. Install essential services on targets (`ssh`, `apache2`).
5. Install analysis tools on analyst (`nmap`, `tcpdump`, `wireshark`).
6. Capture and analyze traffic.
7. Optional NAT adapter for Internet updates.

**Netplan Template:**

```yaml
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    <interface>:
      dhcp4: false
      addresses:
        - <static-ip>/24
```

Apply with:

```bash
sudo netplan apply
```

**Hosts File Template:**

```
<analyst-ip> analyst
<target1-ip> target1
<target2-ip> target2
```

Append with:

```bash
sudo cp /etc/hosts /etc/hosts.bak
sudo sed -i '/analyst/d; /target1/d; /target2/d' /etc/hosts
cat <<'EOF' | sudo tee -a /etc/hosts
<analyst-ip> analyst
<target1-ip> target1
<target2-ip> target2
EOF
```

**Example Commands Executed:**

```bash
# Set hostnames
sudo hostnamectl set-hostname analyst
sudo hostnamectl set-hostname target1
sudo hostnamectl set-hostname target2

# Apply Netplan
sudo netplan apply
ip a

# Install SSH & Apache (targets)
sudo apt update
sudo apt install -y openssh-server apache2
sudo systemctl enable --now ssh
sudo systemctl enable --now apache2

# Install analyst tools
sudo apt update
sudo apt install -y nmap tcpdump wireshark
sudo usermod -aG wireshark $USER
mkdir -p ~/lab-results
chmod 700 ~/lab-results

# Capture traffic
sudo tcpdump -i <interface> host target1 -w ~/lab-results/handshake-$(date +%s).pcap

# Run scans
nmap -sn target1 target2 -oA ~/lab-results/scan-hosts
sudo nmap -sS -T4 -p 22,80,443 target1 -oA ~/lab-results/scan-sS-target1
sudo nmap -sV -p 22,80,443 target1 -oA ~/lab-results/scan-sV-target1
```

**Notes:**

* Keep lab network isolated.
* NAT adapter is optional and only for updates.
* Save snapshots after setup for easy rollback.
