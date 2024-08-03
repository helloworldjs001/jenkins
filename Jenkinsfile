pipeline {
  agent {
    docker {
      image 'node:latest'
      args '-u root:root'
    }
  }
  stages {
    stage('install playwright') {
      steps {
        sh '''
          npm i -D @playwright/test
          npx playwright install
          npx playwright install-deps
        '''
      }
    }
    stage('help') {
      steps {
        sh 'npx playwright test --help'
      }
    }
    stage('test') {
      steps {
        sh '''
          npx playwright test --list
          npx playwright test
        '''
      }
    }
  }
  post {
    success {
      mail to: 'test.adam011@gmail.com',
           subject: "Jenkins Build Success: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
           body: "The build was successful!\n\nBuild details:\nJob: ${env.JOB_NAME}\nBuild Number: ${env.BUILD_NUMBER}\nURL: ${env.BUILD_URL}"
    }
    failure {
      mail to: 'test.adam011@gmail.com',
           subject: "Jenkins Build Failure: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
           body: "The build failed.\n\nBuild details:\nJob: ${env.JOB_NAME}\nBuild Number: ${env.BUILD_NUMBER}\nURL: ${env.BUILD_URL}\n\nPlease check the console output for more details."
    }
  }
}
