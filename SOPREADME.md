# Standard Operating Procedure (SOP) for Migrate 

**Title:** Managing Database Schema Migrations with migrate

| Author | Created On | Version | Last Updated By | Last Edited On | Level | Reviewer |
|--------|------------|---------|-----------------|----------------|--------|----------|
| Asma Badr Khan | 2025-10-31 | 1.0 | Asma Badr Khan | 2025-10-31 | Internal Review | Team |

---

## **Table of Contents**

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation Guide](#installation-guide)
   - [3.1 Install via Binary or Package](#31-install-via-binary-or-package)
   - [3.2 Install via Go Toolchain](#32-install-via-go-toolchain)
   - [3.3 Verify Installation](#33-verify-installation)
4. [Procedure](#procedure)
   - [4.1 Prepare Migrations Directory](#41-prepare-migrations-directory)
   - [4.2 Create Migration Files](#42-create-migration-files)
   - [4.3 Running Migrations (Up/Down/Steps)](#43-running-migrations-updownsteps)
   - [4.4 Configure for CI/CD or Automation](#44-configure-for-cicd-or-automation)
5. [Workflow Diagram](#workflow-diagram)
6. [Best Practices](#best-practices)
7. [Troubleshooting & Tips](#troubleshooting--tips)
8. [Conclusion](#conclusion)
9. [Contact Information](#contact-information)
10. [References](#references)

---

## **Introduction**

The **Go Migrate Tool** (migrate) is a lightweight, open-source command-line utility designed to manage **database schema migrations** efficiently and safely. It enables developers and DevOps teams to version, apply, and roll back schema changes across multiple environments.  

This SOP outlines a standardized approach to **installing, configuring, and using the Migrate tool**, ensuring consistent, auditable, and reversible schema updates in production and development environments. The tool supports several databases like PostgreSQL, MySQL, SQLite, and MongoDB.

---

## **Prerequisites**

Before starting, ensure you have:
- **Go** installed (for source builds)
- Access to a supported **database** (PostgreSQL, MySQL, SQLite, etc.)
- Permissions to modify schema or create tables
- A version-controlled repository (e.g., Git)
- Basic knowledge of SQL syntax and database concepts

---

## **Installation Guide**

### **3.1 Install via Binary or Package**

For Linux/macOS/Windows:

```bash
curl -L https://github.com/golang-migrate/migrate/releases/download/vX.Y.Z/migrate.$OS-$ARCH.tar.gz | tar xvz
sudo mv migrate.$OS-$ARCH /usr/local/bin/migrate
````

On macOS (via Homebrew):

```bash
brew install golang-migrate
```

For Debian/Ubuntu systems:

```bash
curl -fsSL https://packagecloud.io/golang-migrate/migrate/gpgkey | sudo gpg --dearmor -o /etc/apt/keyrings/migrate.gpg
echo "deb [signed-by=/etc/apt/keyrings/migrate.gpg] https://packagecloud.io/golang-migrate/migrate/ubuntu/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/migrate.list
sudo apt-get update && sudo apt-get install -y migrate
```

---

### **3.2 Install via Go Toolchain**

If you prefer building from source:

```bash
go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
```

> Replace 'postgres' with the appropriate driver tags (e.g., mysql, sqlite3) for your database.

---

### **3.3 Verify Installation**

To confirm installation:

```bash
migrate -version
```

Expected output:
v4.xx.x — the installed version.
Check available commands with:

```bash
migrate -help
```

---

## **Procedure**

### **4.1 Prepare Migrations Directory**

Create a directory in your project to store migration files:

```bash
mkdir migrations
```

Structure:

```
migrations/
  000001_create_users_table.up.sql
  000001_create_users_table.down.sql
  000002_add_email_column.up.sql
  000002_add_email_column.down.sql
```

---

### **4.2 Create Migration Files**

Each migration must have a unique version number and two files: .up.sql (apply) and .down.sql (rollback).

**Example – Up Migration (000001_create_users_table.up.sql):**

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Example – Down Migration (000001_create_users_table.down.sql):**

```sql
DROP TABLE IF EXISTS users;
```

---

### **4.3 Running Migrations (Up/Down/Steps)**

Apply all pending migrations:

```bash
migrate -path ./migrations -database "postgres://user:password@localhost:5432/dbname?sslmode=disable" up
```

Rollback the last migration:

```bash
migrate -path ./migrations -database "postgres://..." down 1
```

Apply specific steps:

```bash
migrate -path ./migrations -database "postgres://..." up 2
```

> The tool automatically tracks applied migrations in a system table (schema_migrations).

---

### **4.4 Configure for CI/CD or Automation**

Integrate with CI/CD pipelines (e.g., Jenkins, GitHub Actions, or GitLab CI):

```bash
migrate -path ./migrations -database "${DATABASE_URL}" up
```

* Use environment variables for credentials.
* Avoid concurrent migrations — serialize execution.
* Rollback automatically on failure if possible.

---

## **Workflow Diagram**

```mermaid
flowchart TD
    A[Start] --> B[Install migrate tool]
    B --> C[Create migrations directory]
    C --> D[Write .up.sql and .down.sql files]
    D --> E[Configure database connection URL]
    E --> F[Run migrate up to apply migrations]
    F --> G[Validate database schema]
    G --> H[Automate in CI/CD pipeline]
    H --> I[Monitor & rollback if needed]
    I --> J[End]
```

---

## **Best Practices**

* Keep migrations **atomic** and **incremental**.
* Always include `.down.sql` for rollback capability.
* Test migrations in **staging** before production.
* Never edit previously applied migrations — create new ones instead.
* Use **semantic versioning** and meaningful filenames.
* Store migrations in **version control** (Git).
* Automate database backups before running migrations.

---

## **Troubleshooting & Tips**

| Issue                   | Cause                            | Solution                                          |
| ----------------------- | -------------------------------- | ------------------------------------------------- |
| *Unknown driver*        | Database driver tag missing      | Rebuild with correct `-tags`                      |
| *Connection error*      | Invalid DB URL                   | Verify credentials and encoding                   |
| *Dirty migration state* | Partial migration failed         | Clean or mark version manually after verification |
| *Permission denied*     | Insufficient database privileges | Grant proper DDL access                           |
| *Migrations not found*  | Incorrect path                   | Ensure `-path` matches directory                  |

---

## **Conclusion**

The **Go Migrate Tool** provides a reliable, versioned, and consistent way to handle database schema changes across environments.
Following this SOP ensures:

* Smooth collaboration between developers and DBAs
* Reliable version tracking
* Reduced risk of schema conflicts
* Streamlined integration into CI/CD workflows

Proper use of Migrate strengthens database governance, scalability, and system integrity.

---

## **Contact Information**

| Name           | Email Address                                                           |
| -------------- | ----------------------------------------------------------------------- |
| Asma Badr Khan | [asma.badr.khan.snaatak@mygurukulam.com](mailto:asma.badr.khan.snaatak@mygurukulam.com) |

---

## **References**

| Topic                  | Link                                                                                                                                       | Description                   |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------- |
| Go Migrate (GitHub)    | [https://github.com/golang-migrate/migrate](https://github.com/golang-migrate/migrate)                                                     | Official tool repository      |
| BetterStack Guide      | [https://betterstack.com/community/guides/scaling-go/golang-migrate/](https://betterstack.com/community/guides/scaling-go/golang-migrate/) | Comprehensive usage guide     |
| CI/CD Integration Docs | [https://docs.github.com/actions](https://docs.github.com/actions)                                                                         | Workflow automation reference |
