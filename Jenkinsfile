pipeline {
    agent any
    
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
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