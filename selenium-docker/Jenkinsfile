pipeline{

    agent any

    stages{

        stage('Build Jar'){
        agent {
         docker {
           image 'maven:3.9.3-eclipse-temurin-17-focal'
           args '-u root -v /tmp/m2:/root/.m2'
                  }
               }
            steps{
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Image'){
            steps{
                sh 'docker build -t=335022/jk:latest .'
            }
        }

        stage('Push Image'){
            environment{
                DOCKER_HUB = credentials('dockerhub-creds')
            }
            steps{
                sh 'echo ${DOCKER_HUB_PSW} | docker login -u ${DOCKER_HUB_USR} --password-stdin'
                sh 'docker push 335022/jk:latest'
                sh "docker tag 335022/jk:latest 335022/jk:${env.BUILD_NUMBER}"
                sh "docker push 335022/jk:${env.BUILD_NUMBER}"
            }
        }

    }

    post {
        always {
            sh 'docker logout'
        }
    }

}