# **Standard Operating Procedure (SOP)**

## **Title: Managing Python Dependencies Using `requirements.txt`**

| **Author**     | **Created on** | **Version** | **Last Updated by** | **Last Edited On** | **Level** | **Reviewer** |
| -------------- | -------------- | ----------- | ------------------- | ------------------ | --------- | ------------ |
| Liyakath Ali | 2025-10-30     | 1.0         | Syed Rehan Ali      | 2025-10-30         | Internal  | Reviewer     |

---

## **Overview**

This document defines the **standardized process** for managing Python dependencies using the `requirements.txt` file across different environments.
The `requirements.txt` file ensures all developers, testers, and deployment systems install **identical packages and versions**, maintaining environment consistency across development, staging, and production.

---

## **Table of Contents**

* [Introduction](#introduction)
* [Purpose](#purpose)
* [Scope](#scope)
* [Prerequisites](#prerequisites)
* [Procedure](#procedure)

  * [Step 1: Check Existing Environment](#step-1-check-existing-environment)
  * [Step 2: Create a Virtual Environment](#step-2-create-a-virtual-environment)
  * [Step 3: Install Dependencies](#step-3-install-dependencies)
  * [Step 4: Freeze Dependencies to requirements.txt](#step-4-freeze-dependencies-to-requirementstxt)
  * [Step 5: Install Dependencies from requirements.txt](#step-5-install-dependencies-from-requirementstxt)
  * [Step 6: Updating Dependencies](#step-6-updating-dependencies)
  * [Step 7: Removing Unused Packages](#step-7-removing-unused-packages)
* [Best Practices](#best-practices)
* [Troubleshooting](#troubleshooting)
* [Contact Information](#contact-information)
* [References](#references)

---

## **Introduction**

Python projects often depend on multiple third-party libraries. Managing these dependencies manually can lead to version conflicts and deployment failures.
The `requirements.txt` file standardizes the dependency installation process using **pip**, ensuring that everyone uses the same versions of libraries.

A typical `requirements.txt` file looks like:

```
flask==3.0.0
requests==2.31.0
pandas==2.2.3
numpy>=1.26.0
```

---

## **Purpose**

The purpose of this SOP is to:

* Define a **standard approach** for managing Python dependencies.
* Ensure **environment consistency** across development, testing, and production.
* Enable **easy replication** of environments on new systems.
* Minimize issues caused by dependency mismatches.

---

## **Scope**

This SOP applies to:

* Developers and DevOps engineers managing Python-based applications.
* Any system using Python with external dependencies.
* CI/CD environments where reproducibility is critical.

---

## **Prerequisites**

Before proceeding, ensure:

* Python 3.6 or above is installed.
* `pip` is available.
* The virtual environment (`venv`) is activated (recommended).
* Internet access is available to download packages.

Check versions:

```bash
python3 --version
pip3 --version
```

If pip is missing:

```bash
sudo apt install python3-pip -y
```

---

## **Procedure**

### **Step 1: Check Existing Environment**

List all installed packages:

```bash
pip list
```

---

### **Step 2: Create a Virtual Environment**

Creating isolated environments ensures that dependencies do not interfere with system-wide Python installations.

```bash
python3 -m venv venv
source venv/bin/activate   # Linux/macOS
# OR
venv\Scripts\activate      # Windows
```

---

### **Step 3: Install Dependencies**

Install any package required for your project:

```bash
pip install flask requests pandas
```

Verify:

```bash
pip list
```

---

### **Step 4: Freeze Dependencies to `requirements.txt`**

This saves all currently installed packages and their versions:

```bash
pip freeze > requirements.txt
```

Your file may look like:

```
flask==3.0.0
requests==2.31.0
pandas==2.2.3
numpy==1.26.2
```

---

### **Step 5: Install Dependencies from `requirements.txt`**

To replicate the environment on another system:

```bash
pip install -r requirements.txt
```

This installs **exact versions** listed in the file.

---

### **Step 6: Updating Dependencies**

To check outdated packages:

```bash
pip list --outdated
```

Update a specific package:

```bash
pip install --upgrade <package_name>
```

Update all and refresh the requirements file:

```bash
pip freeze > requirements.txt
```

---

### **Step 7: Removing Unused Packages**

If some packages are no longer needed:

1. Uninstall manually:

   ```bash
   pip uninstall <package_name>
   ```
2. Re-freeze to update the requirements file:

   ```bash
   pip freeze > requirements.txt
   ```

---

## **Best Practices**

-Maintain one `requirements.txt` file per project.

-Always activate the virtual environment before installation.

-Use exact versions (`==`) for production reliability.

-Use version ranges (`>=`) only in development environments.

-Commit `requirements.txt` to version control (Git).

-Never commit your `venv/` directory.

-Regularly audit dependencies with:

```bash
pip check
pip list --outdated
```

---

## **Troubleshooting**

| **Issue**                | **Possible Cause**         | **Solution**                                   |
| ------------------------ | -------------------------- | ---------------------------------------------- |
| `pip: command not found` | pip not installed          | Install pip via `sudo apt install python3-pip` |
| `ModuleNotFoundError`    | Missing package            | Run `pip install -r requirements.txt`          |
| Version conflicts        | Different package versions | Use a fresh virtual environment                |
| Permission denied        | System Python usage        | Use `--user` flag or virtual environment       |
| SSL errors               | Missing certificates       | Run `pip install --upgrade certifi`            |

---

## **Contact Information**

| **Name**       | **Email Address**                                                                     |
| -------------- | ------------------------------------------------------------------------------------- |
| Syed Rehan Ali | [syed.rehan.ali.snaatak@mygurukulam.co](mailto:syed.rehan.ali.snaatak@mygurukulam.co) |

---

## **References**

| **Topic**              | **Link**                                                                                                                               | **Description**                          |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| pip User Guide         | [https://pip.pypa.io/en/stable/user_guide/](https://pip.pypa.io/en/stable/user_guide/)                                                 | Official pip usage documentation         |
| Python Packaging Guide | [https://packaging.python.org/en/latest/](https://packaging.python.org/en/latest/)                                                     | Best practices for dependency management |
| requirements.txt       | [https://pip.pypa.io/en/stable/reference/requirements-file-format/](https://pip.pypa.io/en/stable/reference/requirements-file-format/) | Official reference for requirements.txt  |
| Virtual Environments   | [https://docs.python.org/3/library/venv.html](https://docs.python.org/3/library/venv.html)                                             | Official Python venv documentation       |
