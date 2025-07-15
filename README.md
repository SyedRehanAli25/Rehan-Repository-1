# Jenkins Assignment 1 – DevOps Titans

This assignment consists of two Jenkins Pipeline jobs demonstrating Git operations, artifact handling, publishing, and email notifications.

## ‍ Job 1: NinjaFileCreator

- **Type**: Pipeline Job
- **Parameters**:
  - `NINJA_NAME` (String): The name to be written into the file.
- **Stages**:
  1. **Create File**: Generates a file `ninja.txt` in `shared_dir/` containing "`<NINJA_NAME> from DevOps Ninja`".
  2. **Archive Artifact**: Archives `shared_dir/ninja.txt` as a build artifact.
- **Example output**:
DevOps Titan from DevOps Ninja


##  Job 2: NinjaFilePublisher

- **Type**: Pipeline Job
- **Function**: Copies the archived file from Job 1 and publishes it to a web server.
- **Stages**:
1. **Copy Artifact**: Retrieves `ninja.txt` from the last successful build of `NinjaFileCreator`.
2. **Publish**: Deploys the file to `/var/www/html/ninja/`.
- **Post**:
- Sends an email notification to `rehan.ali9325@gmail.com` if the job fails.

##  Artifact & Deployment Flow

[NinjaFileCreator] -- creates --> ninja.txt -- archived --> [NinjaFilePublisher] -- deploys --> Web Server


##  Success Criteria

- File successfully archived in Job 1.
- File successfully deployed to `/var/www/html/ninja/` in Job 2.
- Email notification works on failure.

---
Team: **DevOps Titans**

