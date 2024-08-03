pipeline {
  agent {
    docker {
      image 'node:latest'
      args '-u root:root'
    }
  }
  environment {
    SMTP_HOST = 'smtp.gmail.com'
    SMTP_PORT = '587'
    SMTP_USER = credentials('smtp-username')
    SMTP_PASSWORD = credentials('smtp-password')
  }
  stages {
    stage('Install Playwright') {
      steps {
        sh '''
          npm i -D @playwright/test
          npx playwright install
          npx playwright install-deps
        '''
      }
    }
    stage('Help') {
      steps {
        sh 'npx playwright test --help'
      }
    }
    stage('Test') {
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
          curl -v ${SMTP_HOST}:${SMTP_PORT} || echo "SMTP server connectivity test failed"
        '''
      }
    }
  }
  post {
    success {
      mail to: 'lallsimmu80@gmail.com',
           subject: "Jenkins Build Success: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
           body: "The build was successful!\n\nBuild details:\nJob: ${env.JOB_NAME}\nBuild Number: ${env.BUILD_NUMBER}\nURL: ${env.BUILD_URL}",
           from: 'your-email@example.com',
           smtpHost: "${env.SMTP_HOST}",
           smtpPort: "${env.SMTP_PORT}",
           smtpUser: "${env.SMTP_USER}",
           smtpPassword: "${env.SMTP_PASSWORD}",
           smtpStartTLS: true
    }
    failure {
      mail to: 'lallsimmu80@gmail.com',
           subject: "Jenkins Build Failure: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
           body: "The build failed.\n\nBuild details:\nJob: ${env.JOB_NAME}\nBuild Number: ${env.BUILD_NUMBER}\nURL: ${env.BUILD_URL}\n\nPlease check the console output for more details.",
           from: 'your-email@example.com',
           smtpHost: "${env.SMTP_HOST}",
           smtpPort: "${env.SMTP_PORT}",
           smtpUser: "${env.SMTP_USER}",
           smtpPassword: "${env.SMTP_PASSWORD}",
           smtpStartTLS: true
    }
  }
}
