pipeline {
    environment {
        DEPLOY = "${env.BRANCH_NAME == "master" || env.BRANCH_NAME == "develop" ? "true" : "false"}"
        NAME = "${env.BRANCH_NAME == "master" ? "example" : "example-staging"}"
        DOMAIN = 'localhost'
        REGISTRY = 'vady1/rails-app'
        REGISTRY_CREDENTIAL = 'dockerHub'
        VERSION = "dev"
    }
    agent {
        kubernetes {
            defaultContainer 'jnlp'
            yamlFile 'build.yaml'
        }
    }
    stages {

        stage('Docker Build') {
            when {
                environment name: 'DEPLOY', value: 'true'
            }
            steps {
                container('docker') {
                    sh "docker build -t ${REGISTRY}:${VERSION} ."
                }
            }
        }
        stage('Docker Publish') {
            when {
                environment name: 'DEPLOY', value: 'true'
            }
            steps {
                container('docker') {
                    withDockerRegistry([credentialsId: "${REGISTRY_CREDENTIAL}", url: ""]) {
                        sh "docker push ${REGISTRY}:${VERSION}"
                    }
                }
            }
        }

        stage(' Deploy cassandra ') {
            when {
                environment name: 'DEPLOY', value: 'true'
            }
            steps {
                container('helm') {
                    sh "cd helm/cassandra && helm repo add bitnami https://charts.bitnami.com/bitnami && helm  upgrade --install cassandra  -f values.yaml bitnami/cassandra"
                }
            }
        }
        stage(' Deploy rails app') {
            when {
                environment name: 'DEPLOY', value: 'true'
            }
            steps {
                container('helm') {
                    sh "cd helm && helm upgrade --install rails-app rails-app"
                }
            }
        }
    }
}
