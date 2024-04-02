pipeline {
    agent any
    
    
    stages {
        stage('code') {
            steps {
                echo 'clonening the code '
                git url:"https://github.com/Shoaibraj/terraform-infra.git", branch: "main"
                }
            }
        stage('plan') {
            steps {
                sh "cd /var/lib/jenkins/workspace/project-1"
                sh "terraform init"
                sh "terraform plan"
                }
            }  
        stage('apply') {
            steps {
                sh "terraform apply"
                }
            }      
   }
}