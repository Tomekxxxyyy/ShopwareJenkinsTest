pipeline {
    agent any
    environment {
        DEPLOYMENT_PATH = '/var/www/staging.datakontext.com/releases'
        SYMLINK_PATH = '/var/www/staging.datakontext.com/htdocs/web'
        YOUNGEST_FOLDER = '$(ls -t $DEPLOYMENT_PATH | head -n 1)'
        CURRENT_BUILD = "${currentBuild.startTimeInMillis / 1000}"
        FORMAT = '%Y%m%d%I%M%S'
        DATE = '$(date -d @$CURRENT_BUILD +$FORMAT)'
    }
    stages {
        stage('PrepareEnv') {
            steps {
                sshagent (credentials: ['vagrant']) {
                    sh "ssh vagrant@192.168.33.10 cp -R $YOUNGEST_FOLDER $DEPLOYMENT_PATH/$DATE"
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
                //sh 'ssh ln -sfn $DEPLOYMENT_PATH/$DATE $SYMLINK_PATH'
            }
        }
    }
}