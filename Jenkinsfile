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
        stage('permissions') {
            steps {
                sh 'chmod +x build/backup.sh'
                sh 'chmod +x build/deploy.sh'
                sh 'chmod +x build/clearcache.sh'
                sh 'chmod +x build/changepermissions.sh'
                sh 'chmod +x build/changesymlinks.sh'
                sh 'chmod +x build/deletereleases.sh'
            }
        }
        stage('backup') {
            steps {
                sshagent (credentials: ['vagrant']) {
                   sh 'build/backup.sh'
                }
            }
        }
        stage('deploy') {
            steps {
                sshagent (credentials: ['vagrant']) {
                   sh 'build/deploy.sh'
                }
            }
        }
        stage('clearcache') {
            steps {
                sshagent (credentials: ['vagrant']) {
                   sh 'build/clearcache.sh'
                }
            }
        }
        stage('changepermissions') {
            steps {
                sshagent (credentials: ['vagrant']) {
                   sh 'build/changepermissions.sh'
                }
            }
         }
        stage('changesymlinks') {
            steps {
                sshagent (credentials: ['vagrant']) {
                   sh 'build/changesymlinks.sh'
                }
            }
        }
        stage('deletereleases') {
            steps {
                sshagent (credentials: ['vagrant']) {
                   sh 'build/deletereleases.sh'
                }
            }
        }
    }
}