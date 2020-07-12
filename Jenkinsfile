pipeline {
agent any
environment {
	DOCKER_IMAGE_NAME = "daneshrao/rubyonrails"
}
stages {
	stage('Build Docker Image') {
		steps {
			script {
				app = docker.build(DOCKER_IMAGE_NAME)
				app.inside {
					sh 'echo build completed'
				}
			}
		}
	}
	stage('Push Docker Image') {
		steps {
			script {
				docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
					app.push("${env.BUILD_NUMBER}")
					app.push("latest")
				}
			}
		}
	}

stage('DeployToProduction') {
            steps {
		    script {
			    sh 'echo $DOCKER_IMAGE_NAME:$BUILD_NUMBER'
<<<<<<< HEAD
			    sh 'chmod +x change.sh
			    sh "sh change.sh $DOCKER_IMAGE_NAME:$BUILD_NUMBER"
=======
>>>>>>> 3bd134ae9954ae41f7e7baa0836a60f679ef76ed
			    
		    }
            }
        }
    }	
}
