pipeline {
    agent none

    environment {
        TF_VAR_region = 'us-east-1'
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    parameters {
        booleanParam(name: 'DESTROY', defaultValue: false, description: 'Set to true to destroy resources after apply')
    }

    stages {
        stage('Terraform') {
            agent { label 'Agent1' }
            stages {
                stage('Checkout') {
                    steps {
                        checkout scm
                    }
                }

                stage('Terraform Init') {
                    steps {
                        sh 'terraform init'
                    }
                }

                stage('Terraform Plan') {
                    steps {
                        sh 'terraform plan -out=tfplan'
                    }
                }

                stage('Terraform Apply') {
                    when {
                        expression { return !params.DESTROY }
                    }
                    steps {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }

                stage('Terraform Destroy') {
                    when {
                        expression { return params.DESTROY }
                    }
                    steps {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }

            post {
                always {
                    cleanWs()
                }
                success {
                    echo "Terraform operation completed successfully."
                }
                failure {
                    echo "Terraform operation failed. Check the logs."
                }
            }
        }
    }
}
