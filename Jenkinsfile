pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
        PATH = "/usr/local/bin:$PATH"
        TERRAFORM_STATE_FILE = '/Users/sajufrancis/devops/terraform/aws-infra/terraform.tfstate'
    }

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone Git repository
                git branch: 'dev', url: 'https://github.com/cfsaju/terraform.git'

                sh 'ls -lart'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'echo "=================Terraform Init=================="'
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                        sh 'echo "=================Terraform Plan=================="'
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                        sh 'echo "=================Terraform Apply=================="'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Terrafom Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                        sh 'echo "=================Terraform Apply=================="'
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }

        stage('Post-Provisioning') {
            steps {
                sh 'terraform output'
            }
        }
    }

    post {
        success {
            echo 'Terraform Apply/Destroy completed successfully!'
        }

        failure {
            echo 'Terraform Apply failed!'
        }
    }
} 