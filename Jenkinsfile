pipeline {
    agent { label 'Agent1' }

    parameters {
        booleanParam(name: 'RUN_TF_DESTROY', defaultValue: true, description: 'Destroy the infrastructure after apply?')
    }

    environment {
        // Define the AWS access keys from Jenkins global credentials
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Terraform Init') {
            steps {
                script {
                    // Use the AWS keys stored in Jenkins credentials
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Plan with the AWS credentials
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply with the AWS credentials
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.RUN_TF_DESTROY }
            }
            steps {
                script {
                    // Destroy with the AWS credentials
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
