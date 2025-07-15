# Jenkins Assignment 1 - DevOps Titans

This assignment demonstrates a Jenkins pipeline setup consisting of:

###  NinjaFileCreator (Pipeline Job 1)
- Takes a `NINJA_NAME` parameter
- Creates a file with content: `<NINJA_NAME> from DevOps Ninja`
- Archives the file as a build artifact

###  NinjaFilePublisher (Pipeline Job 2)
- Automatically copies the artifact from `NinjaFileCreator`
- Publishes it to `/var/www/html/ninja/ninja.txt`
- Sends email notification on failure

###  Pipeline Features Used
- Parameterized builds
- Artifact archiving and copy
- Post actions: `mail`
- Custom sudoers configuration for Jenkins shell tasks

---

###  Team: DevOps Titans
- Rehan (Lead)
- Harsh
- Prakash


