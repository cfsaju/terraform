pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        TF_VAR_aws_access_key = credentials('AWS_ACCESS_KEY')
        TF_VAR_aws_secret_key = credentials('AWS_SECRET_KEY')
    }

    stages {
        stage('checkout Code') {
            steps {
                git 'https://github.com/cfsaju/terraform.git'
            }
        }

        stage('Initialize Terraform'){
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan'){
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }
        stage ('Manual Approval') {
            steps {
                input message: 'Apply Terraform changes?', ok: 'Proceed'
            }

        }

        stage ('Post-Provisioning'){
            steps {
                sh 'terraform output'
            }
        }

    }
            
    post {

        success {
            echo 'Terraform Apply completed successfully!'
        }

        failure {
            echo 'Terraform Apply failed!'
        }

    }


}