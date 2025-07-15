# Assignment 3 - Ansible Infra Setup and App Deployment

## Directory Structure
- infra_setup_role/: Role to setup MySQL, JDK11, Tomcat, and deploy WAR.
- spring3hibernate_app.war: WAR file built with Maven from https://github.com/opstree/spring3hibernate
- deploy_infra_playbook.yml: Main playbook to run the deployment

## Usage

1. Build WAR file locally using Maven:

```bash
git clone https://github.com/opstree/spring3hibernate.git
cd spring3hibernate
mvn clean package
cp target/spring3hibernate.war ~/ansible-assignments/assignment3/spring3hibernate_app.war
