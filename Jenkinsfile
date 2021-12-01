pipeline {
  agent any
  stages {
    stage('检出') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: env.GIT_BUILD_REF]],
        userRemoteConfigs: [[url: env.GIT_REPO_URL, credentialsId: env.CREDENTIALS_ID]]])
      }
    }
    stage('测试') {
      steps {
        echo '单元测试中...'
        sh 'bundle config mirror.https://rubygems.org https://gems.ruby-china.com'
        sh 'bundle install --system'
        sh 'yarn'
        sh 'bundle exec rake test'
        junit 'test/reports/*.xml'
        echo '单元测试完成.'
      }
    }
    stage('打包镜像') {
      steps {
        sh "docker build -t ${ARTIFACT_IMAGE}:${env.GIT_BUILD_REF} ."
        sh "docker tag ${ARTIFACT_IMAGE}:${env.GIT_BUILD_REF} ${ARTIFACT_IMAGE}:latest"
      }
    }
    stage('推送到制品库') {
      steps {
        script {
          docker.withRegistry("${CCI_CURRENT_WEB_PROTOCOL}://${ARTIFACT_BASE}", "${env.DOCKER_REGISTRY_CREDENTIALS_ID}") {
            docker.image("${ARTIFACT_IMAGE}:${env.GIT_BUILD_REF}").push()
            docker.image("${ARTIFACT_IMAGE}:latest").push()
          }
        }

      }
    }
  }
  environment {
    ARTIFACT_BASE = "${CCI_CURRENT_TEAM}-docker.pkg.${CCI_CURRENT_DOMAIN}"
    ARTIFACT_IMAGE = "${ARTIFACT_BASE}/${PROJECT_NAME}/${DEPOT_NAME}/${DEPOT_NAME}"
  }
}