pipeline {
  agent any

  parameters {
    booleanParam(name: 'RUN_TF_APPLY', defaultValue: true, description: 'Apply the Terraform plan?')
    booleanParam(name: 'RUN_TF_DESTROY', defaultValue: true, description: 'Destroy the infrastructure after apply?')
  }

  environment {
    AWS_REGION = "us-east-1"
  }

  stages {
    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([[
          $class: 'UsernamePasswordMultiBinding',
          credentialsId: 'aws-creds-id',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          sh '''
            terraform plan -out=tfplan \
              -var="aws_access_key=${AWS_ACCESS_KEY_ID}" \
              -var="aws_secret_key=${AWS_SECRET_ACCESS_KEY}"
          '''
        }
      }
    }

    stage('Terraform Apply') {
      when {
        expression { params.RUN_TF_APPLY }
      }
      steps {
        input message: "Confirm Apply: Proceed with terraform apply?"
        sh 'terraform apply -auto-approve tfplan'
      }
    }

    stage('Terraform Destroy') {
      when {
        expression { params.RUN_TF_DESTROY }
      }
      steps {
        input message: "Confirm Destroy: Are you sure you want to destroy the infrastructure?"
        withCredentials([[
          $class: 'UsernamePasswordMultiBinding',
          credentialsId: 'aws-creds-id',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          sh '''
            terraform destroy -auto-approve \
              -var="aws_access_key=${AWS_ACCESS_KEY_ID}" \
              -var="aws_secret_key=${AWS_SECRET_ACCESS_KEY}"
          '''
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
