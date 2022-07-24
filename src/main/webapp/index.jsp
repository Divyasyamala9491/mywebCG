<html>
  <body>
    <h1>JENKINS AUTOMATION PROJECT</h1>
    <h1>using git maven jenkins docker docker hub to deploy the slave node to the application</h1>
    <h2>by using below steps</h2>
    <h2>node {
    def buildNumber = BUILD_NUMBER
    stage("Git Clone") {
        git url: 'https://github.com/thennetivamsi/mywebCG.git', branch:'master'
    }
    stage("Maven Clean Package") {
        def mavenHome= tool name: "Maven", type: "maven"
        sh "${mavenHome}/bin/mvn clean package"
    }
    stage("Build Docker Image") {
        sh "docker build -t thennetivamsikumar/java-web-app-docker:${buildNumber} ." 
    }
    stage("Docker Login And Push") {
        withCredentials([string(credentialsId: 'dockerpasswd', variable: 'dockerpasswd')]) {
            sh "docker login -u thennetivamsikumar -p ${dockerpasswd}"
        }
        sh "docker push thennetivamsikumar/java-web-app-docker:${buildNumber}"
    }
    stage("Deploy Application as Docker Container in Docker Deployment Server") {
        sshagent(['Docker_Dev_Server']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.82.42 docker rm -f mywebjavacontainer ||true"
            ss "ssh -o StrictHostKeyChecking=no ubuntu@172.31.82.42 docker run -d -p 8080:8080 --name mywebjavacontainer thennetivamsikumar/java-web-app-docker:${buildNumber}"
        }
    }
}<h2>
      </body>
      </html>
