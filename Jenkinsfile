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
		    script{
                   	    sh 'gcloud container clusters get-credentials test-cassandra --zone us-central1-c --project hybrid-matrix-269303'	
			    sh 'kubectl get pods'
			    
		    }
            }
        }
}
}
