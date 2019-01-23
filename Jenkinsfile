pipeline {
    agent any
    environment {
        DEPLOYMENT_PATH = '/var/www/staging.datakontext.com/releases'
        SYMLINK_PATH = '/var/www/staging.datakontext.com/htdocs/web'
        MYSQLDUMP_PATH = 'shopware > /var/www/staging.datakontext.com/backup'
        CURRENT_BUILD = "${currentBuild.startTimeInMillis /1000}"
        FORMAT = '%Y%m%d%H%M%S'
        CONNECTION = 'vagrant@192.168.33.10'
    }
    stages {
        stage('Backup') {
            steps {
                sshagent (credentials: ['vagrant']) {
                    sh 'ssh ${CONNECTION} mysqldump -u $LOGIN -p$PASSWORD ${MYSQLDUMP_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT).sql'
                    sh 'ssh ${CONNECTION} cp -R $DEPLOYMENT_PATH/$(ssh ${CONNECTION} ls -t $DEPLOYMENT_PATH | head -n 1) $DEPLOYMENT_PATH/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'tar -czvf themes.tar.gz themes'
                sh 'tar -czvf custom_plugins.tar.gz custom/plugins'
                sh 'tar -czvf engine_plugins.tar.gz engine/Shopware/Plugins/Local'
                sshagent (credentials: ['vagrant']) {
                    sh 'scp themes.tar.gz ${CONNECTION}:${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'scp custom_plugins.tar.gz ${CONNECTION}:${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'scp engine_plugins.tar.gz ${CONNECTION}:${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'ssh ${CONNECTION} tar -xzvf ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)/themes.tar.gz -C ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'ssh ${CONNECTION} tar -xzvf ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)/custom_plugins.tar.gz -C ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'ssh ${CONNECTION} tar -xzvf ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)/engine_plugins.tar.gz -C ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'ssh ${CONNECTION} rm -R ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)/themes.tar.gz'
                    sh 'ssh ${CONNECTION} rm -R ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)/custom_plugins.tar.gz'
                    sh 'ssh ${CONNECTION} rm -R ${DEPLOYMENT_PATH}/$(ssh ${CONNECTION} date -d  @${CURRENT_BUILD} +$FORMAT)/engine_plugins.tar.gz'
                }
                sh 'rm -R themes.tar.gz'
                sh 'rm -R custom_plugins.tar.gz'
                sh 'rm -R engine_plugins.tar.gz'
            }
        }
        stage('Symlink') {
            steps {
                echo 'SymLink'
            }
        }
        stage('Rm') {
            steps {
                sh 'ssh $(vagrant@192.168.33.10 ls -t | tail -n +4 | xargs rm -f)'
            }
        }
    }
}