# TaskManager

**TaskManager** is a simple modular Bash-based utility to manage manual and scheduled task execution with support for metadata, logging, email notifications, and execution history.

---

##  Features

-  Submit tasks with metadata
-  Manual and scheduled (cron-based) execution
-  Execution logging with:
  - Start time
  - End time
  - Duration
  - Status (Success/Failure)
-  Execution history per task
-  Email notification on task completion
-  View current, successful, failed tasks
-  Delete tasks

---

## Project Structure

TaskManager/
├── bin/ # Main CLI and logic scripts
│ ├── TaskManager.sh # Entry point for CLI
│ ├── task_add.sh # Add task from metadata
│ ├── task_exec.sh # Execute a task
│ ├── task_list.sh # List tasks
│ ├── task_delete.sh # Delete task
│ └── task_history.sh # Show execution history
├── lib/ # Helper functions
│ └── utils.sh # Email utility, etc.
├── scripts/ # Task script examples
│ └── backup.sh # Sample script
├── meta/ # Task metadata JSON files
│ └── backup.json
├── logs/ # Global logs (optional)
├── tasks/ # Per-task folders with logs/history
│ └── <taskname>/
│ ├── logs/ # Per-execution logs
│ ├── history.log # Execution history
│ └── meta.json # Copied metadata
└── README.md # Project documentation


---

##  Example

###  Add a Task

./bin/TaskManager.sh -a meta/backup.json
###  Execute a Task
./bin/TaskManager.sh -e backup
###  List Tasks
./bin/TaskManager.sh -l
###  Task History
./bin/TaskManager.sh -h backup
###  Delete a Task
./bin/TaskManager.sh -d backup
 Metadata Format (JSON)

{
  "task_name": "backup",
  "script_path": "/home/ubuntu/TaskManager/scripts/backup.sh",
  "task_type": "manual",
  "schedule": "",
  "notification_email": "rehan.ali9325@gmail.com"
}
 Email Notification

Make sure mailutils is installed for email to work:

sudo apt install mailutils

---


