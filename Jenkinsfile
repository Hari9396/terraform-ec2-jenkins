pipeline {
    agent { label 'Agent1' }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

     stage('Terraform Plan') {
            steps {
                sh '''
                terraform plan \
                -var "aws_access_key=${AWS_ACCESS_KEY_ID}" \
                -var "aws_secret_key=${AWS_SECRET_ACCESS_KEY}" \
                -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
    }
}
