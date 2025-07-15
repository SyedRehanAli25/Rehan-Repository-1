pipeline {
    agent any

    environment {
        TARGET_DIR = '/var/www/html/ninja'
        FILE_NAME = 'ninja.txt'
        EMAIL = 'rehan.ali9325@gmail.com'
    }

    stages {
        stage('Copy Artifact') {
            steps {
                copyArtifacts(
                    projectName: 'NinjaFileCreator',
                    filter: 'shared_dir/ninja.txt',
                    target: 'deploy'
                )
            }
        }

        stage('Publish') {
            steps {
                sh """
                    sudo /bin/mkdir -p ${TARGET_DIR}
                    sudo /bin/cp deploy/shared_dir/${FILE_NAME} ${TARGET_DIR}/
                    sudo /bin/chmod 644 ${TARGET_DIR}/${FILE_NAME}
                """
            }
        }
    }

    post {
        failure {
            mail to: "${EMAIL}",
                 subject: "NinjaFilePublisher FAILED",
                 body: "The job '${env.JOB_NAME}' (build #${env.BUILD_NUMBER}) failed.\n\nCheck logs: ${env.BUILD_URL}"
        }
    }
}

