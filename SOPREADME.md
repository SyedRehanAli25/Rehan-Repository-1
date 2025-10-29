# **Standard Operating Procedure (SOP)**

**Title:** Managing Python Virtual Environments on Linux and Windows Systems

| Author             | Created on | Version | Last updated by | Last Edited On | Level    | Reviewer |
| ------------------ | ---------- | ------- | --------------- | -------------- | -------- | -------- |
| **Syed Rehan Ali** | 2025-10-29 | 1.1     | Syed Rehan Ali  | 2025-10-29     | Internal | Reviewer |

---

## **Table of Contents**

# Table of Contents

1. [Introduction](#introduction)
2. [Purpose](#purpose)
3. [Scope](#scope)
4. [Prerequisites](#prerequisites)
5. [Procedure](#procedure)
   5.1 [System Compatibility Check](#system-compatibility-check)
   5.2 [Installing Dependencies](#installing-dependencies)
   5.3 [Installing Python via Package Manager](#installing-python-via-package-manager)
   5.4 [Installing Python via Tarball](#installing-python-via-tarball)
   5.5 [Creating a Python Virtual Environment (Linux)](#creating-a-python-virtual-environment-linux)
   5.6 [Activating and Deactivating Virtual Environments (Linux)](#activating-and-deactivating-virtual-environments-linux)
   5.7 [Managing Dependencies with requirements.txt](#managing-dependencies-with-requirementstxt)
   5.8 [Removing a Virtual Environment (Linux)](#removing-a-virtual-environment-linux)
   5.9 [Creating and Managing Virtual Environments on Windows](#creating-and-managing-virtual-environments-on-windows)
6. [Verifying Installation](#verifying-installation)
7. [Upgrading Python](#upgrading-python)
8. [Best Practices](#best-practices)
9. [Troubleshooting Tips](#troubleshooting-tips)
10. [Contact Information](#contact-information)
11. [References](#references)
## Introduction

This SOP defines the standardized process for creating, managing, and maintaining Python virtual environments on Linux and Windows systems.
Python virtual environments (`venv`) allow developers to isolate project dependencies, ensuring consistency and preventing conflicts between different projects and system-wide packages.

---

## Purpose

The purpose of this SOP is to:

* Establish a consistent process for managing Python environments across Linux and Windows.
* Enable isolation of dependencies per project.
* Enhance portability, reproducibility, and maintainability in development and production setups.

---

## **3. Scope**

This SOP applies to:

* Developers, DevOps engineers, and system administrators managing Python-based projects on Linux or Windows.
* Any environment where multiple projects require different Python package versions.

---

## **4. Prerequisites**

Before proceeding:

* Ensure **Python 3.6+** is installed with **pip**.
* Verify **internet connectivity**.
* Confirm appropriate **sudo or administrator privileges**.

**Check Python Installation**

**Linux**

```bash
python3 --version
pip3 --version
```

**Windows (PowerShell)**

```powershell
python --version
pip --version
```

If Python is missing:

* **Linux:**

  ```bash
  sudo apt install python3 python3-pip python3-venv -y
  ```
* **Windows:** Download from [https://www.python.org/downloads/](https://www.python.org/downloads/) and check **“Add Python to PATH”** during installation.

---

## **5. Procedure**

### **5.1 System Compatibility Check**

**Linux**

```bash
if [ -f /etc/os-release ]; then
  . /etc/os-release
  echo "Detected OS: $NAME"
fi
python3 --version
```

**Windows (PowerShell)**

```powershell
[System.Environment]::OSVersion.Version
python --version
```

---

### **5.2 Installing Required Packages**

**Linux**

```bash
sudo apt-get update -y
sudo apt-get install -y python3-venv python3-pip
python3 -m pip install --upgrade pip
```

**Windows (PowerShell)**

```powershell
python -m pip install --upgrade pip
```

---

### **5.3 Creating a Python Virtual Environment (Linux)**

```bash
mkdir ~/my_project && cd ~/my_project
python3 -m venv venv
```

---

### **5.4 Activating and Deactivating Virtual Environments (Linux)**

**Activate**

```bash
source venv/bin/activate
```

**Deactivate**

```bash
deactivate
```

**Check Python path**

```bash
which python
```

Expected output:
`/home/user/my_project/venv/bin/python`

---

### **5.5 Managing Dependencies with `requirements.txt`**

**Export installed packages**

```bash
pip freeze > requirements.txt
```

**Install from file**

```bash
pip install -r requirements.txt
```

**Upgrade packages**

```bash
pip list --outdated
pip install --upgrade <package_name>
```

---

### **5.6 Removing a Virtual Environment (Linux)**

```bash
deactivate  # if active
rm -rf venv/
```

---

### **5.7 Creating and Managing Virtual Environments on Windows**

**Create Project Directory**

```powershell
mkdir C:\Projects\my_project
cd C:\Projects\my_project
```

**Create Virtual Environment**

```powershell
python -m venv venv
```

**Activate Environment**

```powershell
venv\Scripts\activate
```

**Check Python Path**

```powershell
where python
```

Expected output:
`C:\Projects\my_project\venv\Scripts\python.exe`

**Manage Dependencies**

```powershell
pip install -r requirements.txt
pip freeze > requirements.txt
```

**Deactivate**

```powershell
deactivate
```

**Remove Environment**

```powershell
Remove-Item -Recurse -Force venv
```

---

## **6. Best Practices**

* Maintain **separate environments per project**.
* Always **activate** the virtual environment before installing packages.
* Track dependencies in a **`requirements.txt`** file.
* Exclude the `venv/` directory in **`.gitignore`**.
* Regularly update **pip** and dependencies.
* For production, consider **`pipenv`** or **`poetry`** for dependency management.

---

## **7. Troubleshooting Tips**

| Issue                               | Cause                          | Solution                                         |
| ----------------------------------- | ------------------------------ | ------------------------------------------------ |
| ModuleNotFoundError                 | Package not installed in venv  | Activate correct venv and reinstall              |
| `source: command not found` (Linux) | Using non-Bash shell           | Use `. venv/bin/activate`                        |
| `pip not recognized` (Windows)      | Python not added to PATH       | Reinstall Python and enable “Add Python to PATH” |
| Build errors                        | Missing compilers or headers   | `sudo apt install build-essential python3-dev`   |
| Wrong Python version used           | System Python takes precedence | Check using `which python` or `where python`     |

---

## **8. Contact Information**

| Name               | Email Address                                                                         |
| ------------------ | ------------------------------------------------------------------------------------- |
| **Syed Rehan Ali** | [syed.rehan.ali.snaatak@mygurukulam.co](mailto:syed.rehan.ali.snaatak@mygurukulam.co) |

---

## **9. References**

| Topic                     | Link                                                                                         | Description                                   |
| ------------------------- | -------------------------------------------------------------------------------------------- | --------------------------------------------- |
| Python venv Documentation | [https://docs.python.org/3/library/venv.html](https://docs.python.org/3/library/venv.html)   | Official Python venv guide                    |
| PIP User Guide            | [https://pip.pypa.io/en/stable/user_guide/](https://pip.pypa.io/en/stable/user_guide/)       | Managing Python packages with pip             |
| Python Packaging Guide    | [https://packaging.python.org/](https://packaging.python.org/)                               | Official guide for packaging and dependencies |
| Python for Windows        | [https://docs.python.org/3/using/windows.html](https://docs.python.org/3/using/windows.html) | Instructions for using Python on Windows      |
| Ubuntu Python Docs        | [https://wiki.ubuntu.com/Python](https://wiki.ubuntu.com/Python)                             | Ubuntu’s official Python management guide     |
