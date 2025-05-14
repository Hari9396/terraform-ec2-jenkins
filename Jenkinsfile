pipeline {
    agent { label 'Agent1' } // Replace with your Jenkins agent label

    environment {
        TF_VAR_region = 'us-east-1' // Replace with your AWS region
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id') // AWS access key credential (set in Jenkins)
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key') // AWS secret key credential (set in Jenkins)
    }

    parameters {
        booleanParam(name: 'DESTROY', defaultValue: false, description: 'Set to true to destroy resources after apply')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm // Checkout from your Git repository
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Run Terraform plan
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Run Terraform apply if DESTROY is not true
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { return params.DESTROY == true } // Execute only if DESTROY is true
            }
            steps {
                script {
                    // Run Terraform destroy to delete resources
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        always {
            // Clean the workspace after each build
            cleanWs()
        }
        success {
            echo "Terraform apply completed successfully."
        }
        failure {
            echo "Terraform apply failed. Check the logs."
        }
    }
}
