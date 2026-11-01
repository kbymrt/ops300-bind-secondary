
pipeline {
    agent { label 'podman-builder' }

    environment {
        REGISTRY = 'registry.assign.kbappiah.300.ops:5000'
        IMAGE_NAME = 'bind-secondary'
    }

    triggers {
        pollSCM('H/2 * * * *')
    }

    stages {
        stage('Build Image') {
            steps {
                sh '''
                    podman build -t "$REGISTRY/$IMAGE_NAME:$BUILD_NUMBER" .
                '''
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'registry-login',
                    usernameVariable: 'REG_USER',
                    passwordVariable: 'REG_PASS'
                )]) {
                    sh '''
                        set +x
                        printf '%s' "$REG_PASS" | podman login "$REGISTRY" \
                          --username "$REG_USER" --password-stdin

                        podman push "$REGISTRY/$IMAGE_NAME:$BUILD_NUMBER"
                        podman logout "$REGISTRY"
                    '''
                }
            }
        }
    }
}
