# SSL Setup Detailed Documentation

<img width="112" height="112" alt="ssl-image" src="https://github.com/user-attachments/assets/ssl-placeholder-icon.png" />

<details>
<summary>Table of Contents</summary>

1. [Author Table](#author-table)  
2. [Overview](#overview)  
3. [Purpose](#purpose)  
4. [Architecture Overview](#architecture-overview)  
   * [Architecture Diagram](#architecture-diagram)  
5. [Prerequisites](#prerequisites)  
6. [Step-by-Step Implementation](#step-by-step-implementation)  
   * [Step 1: Update System and Install Certbot](#step-1-update-system-and-install-certbot)  
   * [Step 2: Configure Nginx for Your Domain](#step-2-configure-nginx-for-your-domain)  
   * [Step 3: Obtain SSL Certificate from Let’s Encrypt](#step-3-obtain-ssl-certificate-from-lets-encrypt)  
   * [Step 4: Verify and Test HTTPS](#step-4-verify-and-test-https)  
   * [Step 5: Enable Auto-Renewal](#step-5-enable-auto-renewal)  
7. [Verification & Troubleshooting](#verification--troubleshooting)  
8. [Security Notes](#security-notes)  
9. [FAQs](#faqs)  
10. [Reference Table](#reference-table)

</details>

---

## Author Table

| Author         | Created On | Version | Last Updated By | Last Edited On | Reviewer |
|----------------|------------|----------|------------------|----------------|-----------|
| Asma Badr Khan | 2025-11-11 | 1.0 | Asma Badr Khan | 2025-11-11 | Team |

---

## Overview

This document provides a **comprehensive step-by-step guide** for setting up **SSL (Secure Sockets Layer)** certificates using **Let’s Encrypt Certbot** on Nginx.  

It applies to any **domain** or **subdomain** (for example: `notification.ot-microservices.net`) and ensures all communication occurs over **HTTPS**.

SSL setup helps secure traffic between clients and services by **encrypting data in transit**, improving **security**, and **SEO ranking**.

---

## Purpose

The purpose of this documentation is to help teams:
* Secure their domain endpoints using HTTPS.
* Configure Nginx as a reverse proxy for backend services.
* Use **Let’s Encrypt (Certbot)** for free and automated SSL certificate management.
* Ensure automatic certificate renewal and compliance with best practices.

---

## Architecture Overview

### Architecture Diagram

```mermaid
flowchart LR
    subgraph User
        Browser["Client Browser / API Request (HTTPS)"]
    end

    subgraph Nginx
        NginxProxy["Nginx Reverse Proxy (SSL Termination)"]
    end

    subgraph Backend
        NotificationAPI["Notification API (Flask App, port 5001)"]
    end

    subgraph LetsEncrypt
        Certbot["Let's Encrypt Certbot (Certificate Authority)"]
    end

    Browser -->|443: HTTPS| NginxProxy
    NginxProxy -->|Forward HTTP| NotificationAPI
    NginxProxy -->|Renew Certificates| Certbot
````

---

## Prerequisites

| Requirement           | Description                                                   |
| --------------------- | ------------------------------------------------------------- |
| **Domain Name**       | Registered domain (e.g., `notification.ot-microservices.net`) |
| **Server Access**     | Ubuntu/CentOS instance with `sudo` privileges                 |
| **Web Server**        | Nginx or Apache installed                                     |
| **Firewall Rules**    | Ports 80 (HTTP) and 443 (HTTPS) open                          |
| **DNS Configuration** | Domain A record pointing to your server’s public IP           |

---

## Step-by-Step Implementation

---

### Step 1: Update System and Install Certbot

```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx -y
```

📸 *Screenshot Placeholder:*
*Add screenshot of terminal after Certbot installation.*

---

### Step 2: Configure Nginx for Your Domain

Edit or create a new server block:

```bash
sudo nano /etc/nginx/sites-available/notification
```

Add:

```nginx
server {
    listen 80;
    server_name notification.ot-microservices.net;

    location / {
        proxy_pass http://localhost:5001;
    }
}
```

Enable and test configuration:

```bash
sudo ln -s /etc/nginx/sites-available/notification /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

📸 *Screenshot Placeholder:*
*Add screenshot of successful `nginx -t` test.*

---

### Step 3: Obtain SSL Certificate from Let’s Encrypt

Run:

```bash
sudo certbot --nginx -d notification.ot-microservices.net
```

Follow prompts:

* Choose option to **redirect all HTTP traffic to HTTPS**.
* Certbot will automatically edit your Nginx config to use SSL.

📸 *Screenshot Placeholder:*
*Add screenshot showing Certbot success message and certificate path.*

---

### Step 4: Verify and Test HTTPS

Open browser and visit:
[https://notification.ot-microservices.net](https://notification.ot-microservices.net)

Or check via CLI:

```bash
sudo certbot certificates
```

Expected output:

```
Certificate Name: notification.ot-microservices.net
Expiry Date: 2026-02-09 11:00:00+00:00 (VALID: 89 days)
Certificate Path: /etc/letsencrypt/live/notification.ot-microservices.net/fullchain.pem
```

📸 *Screenshot Placeholder:*
*Add screenshot of successful browser lock icon and HTTPS connection.*

---

### Step 5: Enable Auto-Renewal

Test renewal process:

```bash
sudo certbot renew --dry-run
```

Schedule auto-renewal:

```bash
sudo crontab -e
```

Add:

```cron
0 3 * * * certbot renew --quiet
```

---

## Verification & Troubleshooting

| Issue                         | Cause               | Solution                                   |
| ----------------------------- | ------------------- | ------------------------------------------ |
| `Certbot challenge failed`    | DNS not propagated  | Wait for DNS A record to resolve and retry |
| `Nginx reload error`          | Config syntax issue | Run `nginx -t` before reloading            |
| `SSL not applied`             | Port 443 blocked    | Open port 443 in firewall                  |
| `Browser shows mixed content` | Some HTTP assets    | Update all URLs to HTTPS in app config     |
| `Certificate expired`         | Auto-renewal failed | Manually renew using `sudo certbot renew`  |

---

## Security Notes

* Always use **strong Diffie-Hellman parameters** (`openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048`).
* Use **HTTP Strict Transport Security (HSTS)** in Nginx to enforce HTTPS.
* Store certificates only in **root-protected directories** (`/etc/letsencrypt/live`).
* Consider **wildcard certificates** (`*.ot-microservices.net`) for subdomains.
* Monitor certificate expiry alerts via **Certbot hooks** or external monitoring tools.

---

## FAQs

| Question                                                 | Answer                                                                            |
| -------------------------------------------------------- | --------------------------------------------------------------------------------- |
| **Can I use SSL without Nginx?**                         | Yes, Certbot supports Apache, standalone, and Docker modes too.                   |
| **How often do certificates renew?**                     | Every 90 days (Certbot auto-renews).                                              |
| **Can I use the same certificate for multiple domains?** | Yes, by passing multiple `-d` flags or using a wildcard certificate.              |
| **How to check SSL expiry date?**                        | `sudo certbot certificates` or [SSL Labs Test](https://www.ssllabs.com/ssltest/). |
| **Can I use Let’s Encrypt for internal IPs?**            | No, SSL certificates require valid DNS entries (not IPs).                         |

---

## Reference Table

| Reference                   | Description                             | Link                                                                        |
| --------------------------- | --------------------------------------- | --------------------------------------------------------------------------- |
| **SSL Setup POC**           | Proof of Concept document for SSL setup | [GitHub - SSL Setup POC](#)                                                 |
| **Let’s Encrypt (Certbot)** | Official SSL automation documentation   | [Certbot Docs](https://certbot.eff.org/)                                    |
| **Nginx SSL Configuration** | Enable HTTPS in Nginx                   | [Nginx Docs](https://nginx.org/en/docs/http/configuring_https_servers.html) |
| **SSL Labs**                | SSL validation and grading tool         | [SSL Labs Test](https://www.ssllabs.com/ssltest/)                           |
| **Cron Jobs**               | Automating certificate renewal          | [Crontab Guru](https://crontab.guru/)                                       |

---

**Summary:**
This document serves as a comprehensive **guide for SSL implementation** using Let’s Encrypt and Nginx.
It ensures **secure HTTPS communication**, **certificate automation**, and **compliance with best practices** within the **OT Microservices** architecture.
