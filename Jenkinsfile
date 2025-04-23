pipeline {
    agent any

    tools {
        nodejs 'NodeJS'   // ชื่อต้องตรงกับที่ตั้งไว้ใน Jenkins
    }

    environment {
        OPENSHIFT_SERVER = 'https://api.crc.testing:6443'     // แก้ให้ตรงกับ cluster ของคุณ
        OPENSHIFT_TOKEN = credentials('OPENSHIFT_TOKEN')       // ใส่ token ผ่าน Jenkins Credentials
        OPENSHIFT_NAMESPACE = 'myproject'                      // namespace ที่ต้องการ deploy
    }

        stages {
            stage('Clone Repo') {
                steps {
                    git branch: 'main', url: 'https://github.com/alnico1/hello-openshift.git',
                        credentialsId: 'github'
                }
            }


        stage('Build App') {
            steps {
                    sh 'npm install'
                    //sh 'npm run build'
            }
        }

        stage('Login to OpenShift') {
            steps {
                sh '''
                    oc logout 2>/dev/null || true
                    oc login ${OPENSHIFT_SERVER} --token=${OPENSHIFT_TOKEN} --insecure-skip-tls-verify
                '''
            }
        }

        stage('Deploy to OpenShift') {
            steps {
                dir('hello-openshift') {
                    sh '''
                        oc project ${OPENSHIFT_NAMESPACE}

                        # Create new app (ครั้งแรกเท่านั้น)
                        if ! oc get dc my-node-app > /dev/null 2>&1; then
                            oc new-app . --name=my-node-app
                            oc expose svc/my-node-app
                        else
                            oc start-build my-node-app --from-dir=. --follow
                        fi
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
        }
    }
}

