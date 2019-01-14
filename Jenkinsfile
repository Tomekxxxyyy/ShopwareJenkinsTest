pipeline {
    agent any
    environment {
        DEPLOYMENT_PATH = '/var/www/staging.datakontext.com/releases'
        SYMLINK_PATH = '/var/www/staging.datakontext.com/htdocs/web'
        CURRENT_BUILD = "${currentBuild.startTimeInMillis /1000}"
        FORMAT = '%Y%m%d%H%M%S'
    }
    stages {
        stage('Backup') {
            steps {
                sshagent (credentials: ['vagrant']) {
                    sh 'ssh vagrant@192.168.33.10 cp -R $DEPLOYMENT_PATH/$(ssh vagrant@192.168.33.10 ls -t $DEPLOYMENT_PATH | head -n 1) $DEPLOYMENT_PATH/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy'
            }
        }
        stage('SymLink') {
            steps {
                echo 'SymLink'
            }
        }
    }
}