pipeline {
    agent { label 'Agent1' }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Hari9396/terraform-ec2-jenkins.git'
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
            steps {
                input message: "Approve to applys?"
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
