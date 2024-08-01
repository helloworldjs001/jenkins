pipeline {
  agent { dockerfile true } // Use Dockerfile as the agent for the pipeline

  stages {
    stage('Test') {
      steps {
        sh '''
          curl --version // Check the version of curl
          node --version // Check the version of Node.js
          npm --version  // Check the version of npm
        '''
      }
    }
  }
}
