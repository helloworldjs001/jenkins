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
          npx playwright test --reporter=html
        '''
      }
    }
    stage('Archive Reports') {
      steps {
        archiveArtifacts artifacts: '**/playwright-report/**/*', allowEmptyArchive: true
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
      script {
        // Use shell command to list report files
        def reportFiles = sh(script: 'ls -1 playwright-report/**/*', returnStdout: true).trim().split('\n')
        def attachments = reportFiles.collect { file ->
          [path: file, name: file]
        }
        
        mail to: 'lallsimmu80@gmail.com',
             subject: "Jenkins Build Success: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
             body: """The build was successful!

Build details:
Job: ${env.JOB_NAME}
Build Number: ${env.BUILD_NUMBER}
URL: ${env.BUILD_URL}

Please find the attached report.""",
             from: 'your-email@example.com',
             smtpHost: "${env.SMTP_HOST}",
             smtpPort: "${env.SMTP_PORT}",
             smtpUser: credentials('smtp-username'),
             smtpPassword: credentials('smtp-password'),
             smtpStartTLS: true,
             attachments: attachments
      }
    }
    failure {
      script {
        // Use shell command to list report files
        def reportFiles = sh(script: 'ls -1 playwright-report/**/*', returnStdout: true).trim().split('\n')
        def attachments = reportFiles.collect { file ->
          [path: file, name: file]
        }
        
        mail to: 'lallsimmu80@gmail.com',
             subject: "Jenkins Build Failure: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
             body: """The build failed.

Build details:
Job: ${env.JOB_NAME}
Build Number: ${env.BUILD_NUMBER}
URL: ${env.BUILD_URL}

Please check the attached report and the console output for more details.""",
             from: 'your-email@example.com',
             smtpHost: "${env.SMTP_HOST}",
             smtpPort: "${env.SMTP_PORT}",
             smtpUser: credentials('smtp-username'),
             smtpPassword: credentials('smtp-password'),
             smtpStartTLS: true,
             attachments: attachments
      }
    }
  }
}
