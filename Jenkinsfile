pipeline {
  agent {
    docker {
      image 'node:latest'
      args '-u root:root'
    }
  }
   environment {
        SMTP_SERVER = 'smtp.example.com'
        SMTP_PORT = '587'
        SMTP_USER = 'test.adam011@gmail.com'
        SMTP_PASSWORD = 'hlng jvok gpzn tjix '
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
    stage('Test Connectivity') {
      steps {
        sh '''
          echo "Testing SMTP server connectivity..."
          curl -v smtp.example.com:587 || echo "SMTP server connectivity test failed"
        '''
      }
    }
  }
  post {
    success {
      mail to: 'recipient@example.com',
           subject: "Jenkins Build Success: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
           body: "The build was successful!\n\nBuild details:\nJob: ${env.JOB_NAME}\nBuild Number: ${env.BUILD_NUMBER}\nURL: ${env.BUILD_URL}",
           from: 'your-email@example.com'
    }
    failure {
      mail to: 'recipient@example.com',
           subject: "Jenkins Build Failure: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
           body: "The build failed.\n\nBuild details:\nJob: ${env.JOB_NAME}\nBuild Number: ${env.BUILD_NUMBER}\nURL: ${env.BUILD_URL}\n\nPlease check the console output for more details.",
           from: 'your-email@example.com'
    }
  }
}

