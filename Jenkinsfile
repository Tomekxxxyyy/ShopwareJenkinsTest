pipeline {
    agent any
    environment {
        DEPLOYMENT_PATH = '/var/www/staging.datakontext.com/releases'
        SYMLINK_PATH = '/var/www/staging.datakontext.com/htdocs/web'
        CURRENT_BUILD = "${currentBuild.startTimeInMillis /1000}"
        FORMAT = '%Y%m%d%H%M%S'
        DB = 'shopware > /var/www/staging.datakontext.com/backup'
    }
    stages {
        stage('Backup') {
            steps {
                sshagent (credentials: ['vagrant']) {
                    sh 'ssh vagrant@192.168.33.10 mysqldump -u $LOGIN -p$PASSWORD $DB/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT).sql'
                    sh 'ssh vagrant@192.168.33.10 cp -R $DEPLOYMENT_PATH/$(ssh vagrant@192.168.33.10 ls -t $DEPLOYMENT_PATH | head -n 1) $DEPLOYMENT_PATH/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'tar -czvf themes.tar.gz themes'
                sh 'tar -czvf custom_plugins.tar.gz custom/plugins'
                sh 'tar -czvf engine_plugins.tar.gz engine/Shopware/Plugins'
                sshagent (credentials: ['vagrant']) {
                    sh 'scp themes.tar.gz vagrant@192.168.33.10:${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'scp custom_plugins.tar.gz vagrant@192.168.33.10:${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'scp engine_plugins.tar.gz vagrant@192.168.33.10:${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'ssh vagrant@192.168.33.10 tar -xzvf ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)/themes.tar.gz -C ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'ssh vagrant@192.168.33.10 tar -xzvf ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)/custom_plugins.tar.gz -C ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'ssh vagrant@192.168.33.10 tar -xzvf ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)/engine_plugins.tar.gz -C ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)'
                    sh 'ssh vagrant@192.168.33.10 rm -R ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)/themes.tar.gz'
                    sh 'ssh vagrant@192.168.33.10 rm -R ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)/custom_plugins.tar.gz'
                    sh 'ssh vagrant@192.168.33.10 rm -R ${DEPLOYMENT_PATH}/$(ssh vagrant@192.168.33.10 date -d  @${CURRENT_BUILD} +$FORMAT)/engine_plugins.tar.gz'
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
                echo 'Rm'
            }
        }
    }
}