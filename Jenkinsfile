pipeline {
    agent any
    stages {
        stage('Build gtoolkit') {
            steps {
                build(job: '/gtoolkit', wait: false)
            }
        }
    }
}