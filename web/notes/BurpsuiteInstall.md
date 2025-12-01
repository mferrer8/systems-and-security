
# **Burp Suite Community Edition — Installation Guide (Ubuntu)**

## **1. Update System**

```bash
sudo apt update && sudo apt upgrade -y
```

---

## **2. Verify Java Installation**

Burp runs on Java, and Ubuntu usually includes a version already.

Check your Java version:

```bash
java -version
```

If Java is missing, install OpenJDK:

```bash
sudo apt install openjdk-17-jre -y
```

---

## **3. Download Burp Suite Community Edition**

Visit the official PortSwigger download page:

**[https://portswigger.net/burp/communitydownload](https://portswigger.net/burp/communitydownload)**

Download the **Linux x64 installer** file (ends with `.sh`).

Move into your Downloads folder:

```bash
cd ~/Downloads
```

Make the installer executable:

```bash
chmod +x burpsuite_community_linux*.sh
```

Run the installer:

```bash
./burpsuite_community_linux*.sh
```

Follow the GUI prompts.

---

## **4. Launch Burp Suite**

After installation completes:

```bash
burpsuite
```

Or launch it from the Applications menu.

---

## **5. Install Burp’s CA Certificate in Firefox**

This step is required to avoid HTTPS errors when intercepting browser traffic.

### **a. Configure Firefox to use Burp as proxy**

In Firefox:

**Settings → Network Settings → Manual proxy configuration**

Set:

* **HTTP Proxy:** `127.0.0.1`
* **Port:** `8080`
* Check **"Use this proxy for all protocols"**
* Click **OK**

---

### **b. Export Burp Certificate**

Inside Burp:
**Proxy → Intercept → Open Browser → Settings → View Certificate → Export**

Save as:

```
burpCA.der
```

---

### **c. Import Certificate into Firefox**

Firefox → Settings → Privacy & Security → Certificates → View Certificates → Authorities → Import

Select `burpCA.der`
Check:
✔ **Trust this CA to identify websites**

---

## **6. Test the Setup**

In Firefox, browse to:

```
http://example.com
```

In Burp, you should see the request under:
**Proxy → HTTP history**

If you see traffic, Burp is working correctly.

---

## **7. Enable/Disable Interception**

* **Intercept ON** = Burp will pause requests
* **Intercept OFF** = Traffic flows normally

Use the button under:
**Proxy → Intercept**

---

## **8. Recommended First Settings**

Inside Burp Suite:

**Project Options → Misc → Disable auto‑updates**
(Prevents nag dialogs)

**User Options → Display → Dark Mode**
(Optional, but nicer on the eyes)

---
