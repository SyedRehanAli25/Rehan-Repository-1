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
5. [Frontend Proxy Setup](#frontend-proxy-setup)
6. [Architecture & Workflow](#architecture--workflow)

   * [Architecture Diagram](#architecture-diagram)
   * [Workflow Diagram](#workflow-diagram)
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

Edit `config.yaml`:

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

---

### Step 4: Add Employee Data

```bash
curl -X POST "http://3.218.208.75:9200/employee-management/_doc/1" \
-H 'Content-Type: application/json' \
-d '{"email": "rehan.ali9325@gmail.com","name": "Rehan Ali"}'
```
<img width="1870" height="99" alt="image" src="https://github.com/user-attachments/assets/3a83ce40-e122-4669-8826-d44683ad9d81" />

---

### Why We Are Using Elasticsearch

Elasticsearch is used in the Notification API to efficiently **store, search, and retrieve employee data** and **log notification statuses**. Its advantages include:

* **Fast Search & Retrieval:** Quickly fetch employee emails and related metadata for notifications.
* **Scalable Storage:** Handle a growing number of employee records without performance degradation.
* **Structured Logging:** Log notification success/failure for auditing and troubleshooting.
* **Integration Friendly:** Seamlessly integrates with Python and other microservices in the system.

By using Elasticsearch, the Notification API ensures that notifications are sent accurately and logged efficiently for future reference.
<img width="1917" height="625" alt="image" src="https://github.com/user-attachments/assets/94e1ba8c-9c8c-46f5-8f57-972ad70673b3" />

---

### Step 5: Fix Python Code Issues

Ensure correct config reads and email sending logic. Run:

```bash
python3 notification_api.py --mode scheduled
python3 notification_api.py --mode external
```

---

### Step 6: Set Config Environment Variable

```bash
export CONFIG_FILE=./config.yaml
```
<img width="1889" height="415" alt="image" src="https://github.com/user-attachments/assets/70007c42-d23f-4fe4-9ede-a3b1fbc353c3" />

---

### Step 7: Run Notification Script

```bash
python3 notification_api.py --mode external
```

---

### Step 8: Optional Cron Scheduling

```cron
0 * * * * CONFIG_FILE=/path/to/config.yaml /usr/bin/python3 /path/to/notification_api.py --mode external
```

---

## Frontend Proxy Setup

```javascript
const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function(app) {
  app.use('/employee', createProxyMiddleware({ target: 'http://localhost:8080', changeOrigin: true }));
  app.use('/salary', createProxyMiddleware({ target: 'http://localhost:8081', changeOrigin: true }));
  app.use('/attendance', createProxyMiddleware({ target: 'http://localhost:8085', changeOrigin: true }));
  app.use('/notification', createProxyMiddleware({ target: 'http://localhost:5001', changeOrigin: true }));
};
```

---

## Architecture & Workflow

### Architecture Diagram

```mermaid
flowchart TD
    subgraph Frontend
        ReactApp["[React App](https://create-react-app.dev/) (localhost:3000)"]
    end

    subgraph Backend_APIs
        EmployeeAPI["[Employee API](https://github.com/OT-MICROSERVICES/employee-api) (localhost:8080)"]
        SalaryAPI["[Salary API](https://github.com/OT-MICROSERVICES/salary-api) (localhost:8081)"]
        AttendanceAPI["[Attendance API](https://github.com/OT-MICROSERVICES/attendance-api) (localhost:8085)"]
        NotificationAPI["[Notification API](https://github.com/OT-MICROSERVICES/notification-worker) (Flask, localhost:5001)"]
    end

    subgraph Elasticsearch_Server
        ES["[Elasticsearch](https://www.elastic.co/elasticsearch/)"]
    end

    subgraph SMTP_Server
        SMTP["[SMTP Server](https://support.google.com/mail/answer/185833) (Gmail/Other)"]
    end

    ReactApp -->|/employee/*| EmployeeAPI
    ReactApp -->|/salary/*| SalaryAPI
    ReactApp -->|/attendance/*| AttendanceAPI
    ReactApp -->|/notification/*| NotificationAPI

    NotificationAPI --> ES
    NotificationAPI --> SMTP
    EmployeeAPI -->|Employee Data| NotificationAPI

    CronJob["[Cron Scheduler](https://crontab.guru/) / Scheduled Mode"] --> NotificationAPI
```

### Workflow Diagram

```mermaid
flowchart LR
    Start["[Start: Trigger Notification](#step-7-run-notification-script)"]
    FetchData["[Fetch Employee Emails](#step-4-add-employee-data) from Elasticsearch"]
    GenerateMsg["[Generate Email Content](#step-5-fix-python-code-issues)"]
    SendEmail["[Send Email via SMTP](#step-3-configure-smtp--elasticsearch)"]
    LogES["[Log Notification Status](#step-4-add-employee-data) in Elasticsearch"]
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
| React Proxy Setup           | Avoiding CORS in development           | [Create React App Docs](https://create-react-app.dev/docs/proxying-api-requests-in-development/)   |
| Cron Jobs                   | Scheduling scripts in Linux            | [Cron Tutorial](https://crontab.guru/)                                                             |
