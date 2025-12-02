# HTTP Basics

This document provides a quick reference for core HTTP concepts used in web applications and beginner web security testing. It is intended as a foundational guide for understanding how web traffic works during reconnaissance, enumeration, and exploitation activities.

---

## 1. What is HTTP?

HTTP (Hypertext Transfer Protocol) is the communication standard used between web browsers and web servers. It is:

* **Stateless** – each request is independent unless cookies, sessions, or tokens are used.
* Typically run on:

  * Port 80 (HTTP)
  * Port 443 (HTTPS, encrypted)

---

## 2. HTTP Request Structure

A basic HTTP request looks like:

```
GET /login HTTP/1.1
Host: example.com
User-Agent: Mozilla/5.0
Accept: */*
```

### Key components:

* **Method**
* **Path**
* **Protocol version**
* **Headers**
* **Body** (only for certain methods like POST, PUT, etc.)

---

## 3. Common HTTP Methods

### GET

* Requests information from a resource.
* Parameters are often in the URL.
* Not secure for sensitive information.

### POST

* Sends data in the body of the request.
* Used for forms, authentication, file uploads, etc.

### HEAD

* Same as GET but returns headers only.
* Good for checking if a page exists.

### PUT

* Creates or replaces a resource.
* Common in API testing.

### DELETE

* Removes a resource.
* Can be dangerous if not properly secured.

---

## 4. HTTP Responses

Example:

```
HTTP/1.1 200 OK
Server: nginx
Content-Type: text/html
Content-Length: 15423
```

Contains:

* **Status code**
* **Headers**
* **Body (HTML, JSON, etc.)**

---

## 5. Important Status Codes

### 2xx – Success

* **200 OK** – Request successful
* **201 Created** – New resource created

### 3xx – Redirects

* **301 Moved Permanently**
* **302 Found**

### 4xx – Client Errors

* **400 Bad Request**
* **401 Unauthorized**
* **403 Forbidden**
* **404 Not Found**

### 5xx – Server Errors

* **500 Internal Server Error**
* **502 Bad Gateway**
* **503 Service Unavailable**

Server-side errors can hint at misconfigurations or vulnerabilities.

---

## 6. Inspecting HTTP with `curl`

A simple and essential way to view raw HTTP traffic:

```
curl -v http://example.com
```

`-v` displays the full request and response:

* Request line
* Response headers
* Server information

---

## 7. Why This Matters for Security

Understanding HTTP fundamentals helps when:

* Testing authentication mechanisms
* Analyzing how data is transmitted
* Intercepting requests with Burp Suite
* Identifying suspicious behavior
* Spotting misconfigured APIs or web servers

This knowledge forms the basis for more advanced skills like:

* XSS
* SQL injection
* Directory traversal
* Authorization bypass
* Web application enumeration

---

## References

* RFC 7230 – HTTP/1.1 Message Syntax and Routing
* MDN Web Docs – Hypertext Transfer Protocol

---

End of file.
