# Burp Suite Quick Guide (Community Edition)

Burp Suite is a web security testing proxy that allows you to intercept, modify, and analyze HTTP/S traffic between your browser and a target application. This guide covers the essentials you need for hands‑on testing in a local lab.

---

## 1. Start Burp Suite

If you’re launching Burp from a `.jar` file:

```bash
java -jar ~/burp.jar &
```

Or run your helper script:

```bash
./run-burp.sh
```

Choose:

* **Temporary Project**
* **Use Burp Defaults**

---

## 2. Configure Your Browser (Firefox)

Burp works by routing browser traffic through its proxy.

### **Proxy Settings**

In Firefox:

```
Settings → Network Settings → Manual Proxy Configuration
HTTP Proxy: 127.0.0.1
Port: 8080
Check: Use this proxy for all protocols
```

### **Certificate (HTTPS) Setup**

To intercept HTTPS, you must import Burp’s CA certificate.

1. Open Firefox and go to:
   `http://burp`
2. Download **CA Certificate**
3. Firefox → Settings → Privacy & Security
4. Scroll to **Certificates → View Certificates**
5. Import the certificate
   ✔️ Trust this CA to identify websites

---

## 📡 3. Core Tools (What You’ll Actually Use)

### ** Proxy → Intercept**

* Shows live HTTP/S requests before they reach the server.
* Toggle Intercept: **Intercept is on/off**
* Modify requests for testing:

  * Parameters
  * Cookies
  * Headers
  * Body fields

**Useful when testing:**

* Authentication bypass
* Tampering with form values
* Session manipulation
* Hidden fields (price, role, etc.)

---

### ** Proxy → HTTP History**

Your timeline of every request/response passing through Burp.

Use it to:

* Re-send a request to Repeater
* Inspect server behavior
* Search parameters and sensitive data

---

### ** Repeater**

Manually modify and resend requests.

Perfect for:

* SQLi payload testing
* XSS payload refinement
* Auth testing
* Manipulating headers/cookies
* Checking server behavior

Shortcut from Proxy/History:
**Right-click → Send to Repeater**

---

### ** Decoder**

Tools for:

* URL encoding/decoding
* Base64
* Hex
* HTML entities
* Hashing

Use this when analyzing encoded payloads.

---

### **📑 Comparer**

Compares two requests or responses.

Useful for:

* Identifying small response differences during fuzzing
* Detecting authentication changes
* Spotting parameter behavior

---

## 🕸️ 4. Common Workflow (Beginner Friendly)

### **1️ Start Burp**

Temporary Project → Use Defaults

### **2️ Configure Firefox proxy**

127.0.0.1:8080

### **3️ Confirm interception**

Visit any site and watch the request appear in **Proxy → Intercept**.

### **4️ Turn off Intercept when browsing normally**

(You usually only turn it on when testing)

### **5️ Open your lab targets**

Examples:

* `http://10.0.0.20`
* DVWA
* Mutillidae
* Tomcat Manager

### **6️ Use HTTP History to analyze requests**

Find POST/GET paths to attack.

### **7️ Send actionable requests to Repeater**

Test payloads manually and watch for changes in the response.

---

## 5. Must‑Know Shortcuts

| Purpose                    | Shortcut             |
| -------------------------- | -------------------- |
| Send to Repeater           | **Ctrl + R**         |
| Send to Decoder            | **Ctrl + D**         |
| Enable/Disable Intercept   | **Ctrl + T**         |
| Forward intercepted packet | **Ctrl + F**         |
| Drop request               | **Ctrl + Shift + D** |

---

## 6. What Community Edition Cannot Do

To avoid confusion:

❌ No Intruder fast attack speeds (rate‑limited)
❌ No automated Scanner
❌ No BApp extensions that require Pro
❌ No full crawl/spider

But Community is still extremely powerful for manual testing.

---

## 7. Safety Notes for Your Lab

* Only use Burp against **your own isolated targets**
* Keep VMs on an internal network
* Never intercept real web apps using Burp without explicit permission

---

## 8. Quick Troubleshooting

### **Firefox says “Proxy Refusing Connections”**

* Burp is not running
* Wrong proxy port
* Using HTTPS proxy instead of HTTP proxy

### **HTTPS pages show certificate errors**

* You did not import Burp’s CA into Firefox
* Browser caching the old certificate
  → Restart Firefox

### **Nothing appears in HTTP History**

* Intercept is ON
* Wrong proxy settings
* Using another browser (only Firefox is configured)

---
