pipeline {
    agent any
    environment {
        DEPLOYMENT_PATH = '/var/www/staging.datakontext.com/releases'
        SYMLINK_PATH = '/var/www/staging.datakontext.com/htdocs/web'
        MYSQLDUMP_PATH = '/var/www/staging.datakontext.com/backup'
        CURRENT_BUILD = "$currentBuild.startTimeInMillis"
        FORMAT = '%Y%m%d%H%M%S'
        CONNECTION = 'vagrant@192.168.33.10'
    }
    stages {
        stage('Backup') {
            steps {
                sh 'chmod + x build/backups.sh'
                sh 'chmod + x build/deploy.sh'
            }
        }
        stage('Backup') {
            steps {
                sshagent (credentials: ['vagrant']) {
                   sh 'build/backup.sh'
                }
            }
        }
    }
}