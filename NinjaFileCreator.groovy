pipeline {
    agent any

    parameters {
        string(name: 'NINJA_NAME', defaultValue: 'Rehan', description: 'Enter your Ninja name')
    }

    stages {
        stage('Create File') {
            steps {
                sh """
                    mkdir -p shared_dir
                    echo "${params.NINJA_NAME} from DevOps Ninja" > shared_dir/ninja.txt
                """
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'shared_dir/ninja.txt', onlyIfSuccessful: true
            }
        }
    }
}

