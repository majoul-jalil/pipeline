import groovy.json.JsonSlurper
pipeline{
    
     environment
    {
        MYSQL_SERVER_IP='serverdb.mysql.database.azure.com'
        MYSQL_USERNAME='admin1'
        MYSQL_PASSWORD='Aa22557646'
        registryName = 'myakacrregistry'
        registryUrl = 'myakacrregistry.azurecr.io'
        registryCredential = 'ACR' 
        
        dockerImage = ''  
    }
    agent none
    stages {    
          stage( ' permission ' ){
         agent any

            steps {
              
                sh "sudo chown root:jenkins /run/docker.sock"
            }

        } 
            
            stage( ' Build - Maven package ' ){
                 agent any
                     steps {
                         script {
                             
                             sh 'mvn clean -Denv.MYSQL_SERVER_IP=${MYSQL_SERVER_IP}  -Denv.MYSQL_USERNAME=${MYSQL_USERNAME} -Denv.MYSQL_PASSWORD=${MYSQL_PASSWORD} package  -P MySQL '
                          
                          }
                        }
        }
           
        stage('Docker Build and Tag') { 
             agent any
                     steps {
                       script {dockerImage = docker.build registryName}
                       
                         
                }    
        }
        
        stage('run image'){
             agent any
             
            steps
   { 
                sh '  docker run  -d   -p 8003:8080 --name imagepet myakacrregistry:latest ' 
 
            } 
        } 
        stage('Publish image to Docker Hub') {
             agent any
          steps{ 

                     script {
                         docker.withRegistry( "http://${registryUrl}", registryCredential ) {

                        dockerImage.push()} 
                   
                }
                
                         
            }
        }
          stage( ' suppression image docker ' ){
                 agent any
                     steps {
                         script {
                          
                           
               sh 'docker stop imagepet'
               sh 'docker rm imagepet'
               sh 'docker rmi -f myakacrregistry'
                sh 'docker rmi -f myakacrregistry.azurecr.io/myakacrregistry'
                            }
                        }
        }
         
        stage('Prepare Environment') {
              
        agent any
        
       steps
{ 
          
            sh 'az login --service-principal -u beb5657b-2a3f-4e5b-b40c-e4bd788e5e2b -p b4yL2bwwLSREdtV_xY4i60IOjZh-qY4oBC -t 905bdb05-128b-4424-a706-766bdb164be1'
            
            sh 'az aks get-credentials --resource-group groupebase --name AKSCLUSTER --overwrite-existing'
}}
         stage('Deploy') {
         agent any
         
        steps
{ 
            sh 'kubectl apply -f deploy.yaml '
        }}
    }
}
