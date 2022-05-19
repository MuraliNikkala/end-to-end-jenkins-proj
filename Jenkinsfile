pipeline {
    agent any
    stages {

        stage('Clone Repo') {
          steps {
            sh 'rm -rf packer-terraform-jenkins-docker'
            sh 'git clone https://github.com/MuraliNikkala/packer-terraform-jenkins-docker.git'
            }
        }
		
		stage('Packer Build AMI') {
          steps {
            
            sh 'pwd'
            sh 'ls -al'
            sh 'cp /var/lib/jenkins/workspace/Pipeline-Testing/packer-terraform-jenkins-docker/*.* .'
            sh 'ls -al'
            sh 'packer build packer.json'
            }
        }
				
		 stage('Deploy EC2 Server') {
           steps {
		    sh 'terraform init'
            sh 'terraform apply --auto-approve'
            }
        }

        stage('Build Docker Image') {
          steps {
            sh 'mkdir -p /var/lib/jenkins/workspace/pipeline2'
	    sh 'cd /var/lib/jenkins/workspace/Pipeline-Testing/packer-terraform-jenkins-docker'
	    sh 'cp  /var/lib/jenkins/workspace/Pipeline-Testing/packer-terraform-jenkins-docker/* /var/lib/jenkins/workspace/pipeline2'
            sh 'docker build -t muralinikkala/pipelinetestprod:${BUILD_NUMBER} .'
            }
        }

        stage('Push Image to Docker Hub') {
          steps {
           sh    'docker push muralinikkala/pipelinetestprod:${BUILD_NUMBER}'
           }
        }

        stage('Deploy to Docker Host') {
          steps {
		    sh 'sleep 10s'
            sh    'docker -H tcp://localhost:2375 stop prodwebapp1 || true'
            sh    'docker -H tcp://localhost:2375 run --rm -dit --name prodwebapp1 --hostname prodwebapp1 -p 8000:80 muralinikkala/pipelinetestprod:${BUILD_NUMBER}'
            }
        }

        stage('Check WebApp Rechability') {
          steps {
          sh 'sleep 10s'
          sh ' curl http://localhost:8000'
          }
        }

    }
}
