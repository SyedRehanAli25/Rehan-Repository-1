# Notification API Implementation Document

<img width="112" height="112" alt="image" src="https://github.com/user-attachments/assets/a94cca2d-e9df-43b5-823a-b5f6b59d9563" />

<details>
<summary>Table of Contents</summary>

1. [Authors](#authors)

2. [Overview](#overview)

3. [Prerequisites](#prerequisites)

4. [Step-by-Step Implementation](#step-by-step-implementation)

   * [Step 0: Clone the Repository](#step-0-clone-the-repository)
   * [Step 1: Navigate to Project](#step-1-navigate-to-project)
   * [Step 2: Install Dependencies](#step-2-install-dependencies)
   * [Step 3: Configure SMTP & Elasticsearch](#step-3-configure-smtp--elasticsearch)
   * [Step 4: Add Employee Data](#step-4-add-employee-data)
   * [Why We Are Using Elasticsearch](#why-we-are-using-elasticsearch)
   * [Step 5: Fix Python Code Issues](#step-5-fix-python-code-issues)
   * [Step 6: Set Config Environment Variable](#step-6-set-config-environment-variable)
   * [Step 7: Run Notification Script](#step-7-run-notification-script)
   * [Step 8: Optional Cron Scheduling](#step-8-optional-cron-scheduling)
   * [Step 9: EC2 Metadata Token for Public IP](#step-9-ec2-metadata-token-for-public-ip)

5. [Frontend Proxy Setup](#frontend-proxy-setup)

6. [Architecture & Workflow](#architecture--workflow)

7. [FAQs](#faqs)

8. [Reference Table](#reference-table)

</details>

---
## Author Table

| Author         | Created on | Version | Last updated by | Last Edited On | Reviewer |
| -------------- | ---------- | ------- | --------------- | -------------- | -------- |
| Syed Rehan Ali | 2025-11-10 | 1.1     | Syed Rehan Ali  | 2025-11-10     | Team     |
| Syed Rehan Ali |            | 1.2     | Syed Rehan Ali  |                |          |
| Syed Rehan Ali |            | 1.2     | Syed Rehan Ali  |                |          |

---

## Overview

This document provides a **Step-by-Step Standard Operating Procedure (SOP)** for the **Notification API**, a microservice designed to send email notifications to employees.

The SOP is intended for developers, DevOps engineers, and QA teams deploying, testing, or maintaining the Notification API.

**Notification API repository:** [GitHub - Notification Worker](https://github.com/OT-MICROSERVICES/notification-worker)

---

## Prerequisites

* Python 3.10+
* pip3
* Access to Elasticsearch server
* Gmail account or other SMTP credentials
* EC2 instance with public IP (if deploying on AWS)

---

## Step-by-Step Implementation

### Step 0: Clone the Repository

```bash
git clone https://github.com/OT-MICROSERVICES/notification-worker.git
```

---

### Step 1: Navigate to Project

```bash
cd ~/OT-MICROSERVICES/notification-worker
```

---

### Step 2: Install Dependencies

```bash
pip3 install -r requirements.txt --user
```

---

### Step 3: Configure SMTP & Elasticsearch

Edit config.yaml:

```yaml
smtp:
  from: "rehan.ali9325@gmail.com"
  username: "rehan.ali9325@gmail.com"
  password: "your-app-password"
  smtp_server: "smtp.gmail.com"
  smtp_port: "587"

elasticsearch:
  username: "elastic"
  password: "elastic"
  host: "98.92.131.86"
  port: 9200
```

> **Tip:** Make sure Elasticsearch is configured to listen on `0.0.0.0` in elasticsearch.yml and your **EC2 security group** allows inbound on port 9200.

---

### Step 4: Add Employee Data

```bash
curl -X POST "http://98.92.131.86:9200/employee-management/_doc/1" \
-H 'Content-Type: application/json' \
-d '{"email": "rehan.ali9325@gmail.com","name": "Rehan Ali"}'
```
<img width="1875" height="368" alt="image" src="https://github.com/user-attachments/assets/052bf5c8-b8dc-4325-ab9d-44ea73931097" />

---

### Why We Are Using Elasticsearch

* Fast search & retrieval of employee emails.
* Scalable storage for growing employee records.
* Structured logging of notifications.
* Easy Python integration for queries and updates.
<img width="1915" height="611" alt="image" src="https://github.com/user-attachments/assets/6babef4c-7a9b-454a-b044-8537e4190fc5" />

---

### Step 5: Fix Python Code Issues

Ensure correct config reads and email sending logic:

```bash
python3 notification_api.py --mode scheduled
python3 notification_api.py --mode external
```

---

### Step 6: Set Config Environment Variable

```bash
export CONFIG_FILE=./config.yaml
```

---

### Step 7: Run Notification Script

```bash
python3 notification_api.py --mode external
```
<img width="1919" height="593" alt="image" src="https://github.com/user-attachments/assets/c9f1ddcb-f73b-4598-80c1-481fd43baaa9" />

---

### Step 8: Optional Cron Scheduling

```cron
0 * * * * CONFIG_FILE=/path/to/config.yaml /usr/bin/python3 /path/to/notification_api.py --mode external
```

---

### Step 9: EC2 Metadata Token for Public IP (If Using AWS)

To fetch public IP securely:

```bash
# Get a temporary token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Get public IP
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4
```
<img width="1905" height="787" alt="image" src="https://github.com/user-attachments/assets/b23c4b56-f0b9-461c-aeb7-f3e8de56e164" />

Use this IP in your `config.yaml` if connecting from outside AWS.

---

## Frontend Proxy Setup

```javascript
const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function(app) {
  app.use('/notification', createProxyMiddleware({ target: 'http://localhost:5001', changeOrigin: true }));
};
```

---

## Architecture & Workflow

### Architecture Diagram (Notification API Only)

```mermaid
flowchart TD
    subgraph Notification_System
        Employee["Employee Data / Client"]
        NotificationAPI["Notification API (Flask, localhost:5001)"]
        ES["Elasticsearch (Employee Data & Logs)"]
        SMTP["SMTP Server (Gmail/Other)"]
    end

    Employee --> NotificationAPI
    NotificationAPI --> ES
    NotificationAPI --> SMTP
```

### Workflow Diagram

```mermaid
flowchart LR
    Start["Start: Trigger Notification"]
    FetchData["Fetch Employee Emails from Elasticsearch"]
    GenerateMsg["Generate Email Content"]
    SendEmail["Send Email via SMTP"]
    LogES["Log Notification Status in Elasticsearch"]
    End["End: Notification sent successfully"]

    Start --> FetchData --> GenerateMsg --> SendEmail --> LogES --> End
```

---

## FAQs

* [Why use a proxy in React?](https://create-react-app.dev/docs/proxying-api-requests-in-development/)
* [CORS explanation](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
* [Elasticsearch integration with Python](https://www.elastic.co/guide/en/elasticsearch/client/python-api/current/index.html)

---

## Reference Table

| Reference                   | Description                            | Link                                                                                               |
| --------------------------- | -------------------------------------- | -------------------------------------------------------------------------------------------------- |
| Notification API Repo       | Source code and main repo              | [GitHub](https://github.com/OT-MICROSERVICES/notification-worker)                                  |
| Gmail App Passwords         | How to generate app passwords for SMTP | [Google Account](https://myaccount.google.com/apppasswords)                                        |
| Elasticsearch Python Client | Official Python client documentation   | [Elastic Docs](https://www.elastic.co/guide/en/elasticsearch/client/python-api/current/index.html) |
| Cron Jobs                   | Scheduling scripts in Linux            | [Cron Tutorial](https://crontab.guru/)           
