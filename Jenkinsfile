pipeline{
     environment
    {
        MYSQL_SERVER_IP='serverdb.mysql.database.azure.com'
        MYSQL_USERNAME='admin1'
        MYSQL_PASSWORD='Aa22557646'
        registry = "majoul/pipeline" 

        registryCredential = 'pipeline1233' 

        dockerImage = ''  
    }
    agent none
    stages {    
             stage( ' suppression image docker ' ){
                 agent any
                     steps {
                         script {
                           
                            sh 'docker ps -aq | xargs --no-run-if-empty docker stop' 
                echo ' remove all docker containers' 
                sh 'docker ps -aq | xargs --no-run-if-empty docker rm'
                            }
                        }
        } 
            stage( ' Build - Maven package ' ){
                 agent any
                     steps {
                         script {
                           
                          }
                        }
        }
           
        stage('Docker Build and Tag') { 
             agent any
           steps { 
               
                sh 'docker build -t samplewebapp .' 
               
                //sh 'docker tag samplewebapp petclinic/samplewebapp:$BUILD_NUMBER' 
               
          } 
        }
        
        stage('run image'){
             agent any
             
            steps
   { 
                sh ' docker run  -d   -p 8003:8080 --name imagepet samplewebapp ' 
 
            } 
        } 
         stage('Deploy our image') { 
            agent any
            steps { 

                script { 

                  sh '  docker.withRegistry( '', registryCredential ) { samplewebapp.push() } '

                         

                    

                } 

            }

        }  
    }
}
