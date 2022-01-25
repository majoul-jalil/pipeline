pipeline{
     environment
    {
        MYSQL_SERVER_IP='serverdb.mysql.database.azure.com'
        MYSQL_USERNAME='admin1'
        MYSQL_PASSWORD='Aa22557646'
        registry = "majoul/pipeline" 

        registryCredential = 'pipeline1233' 
        a = ''
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
                               echo ' mvn  clean install '
                             echo 'mvn -Denv.MYSQL_SERVER_IP=${MYSQL_SERVER_IP}  -Denv.MYSQL_USERNAME=${MYSQL_USERNAME} -Denv.MYSQL_PASSWORD=${MYSQL_PASSWORD} package -P MySQL '
                          
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

                  sh '  docker.withRegistry( a, registryCredential ) { samplewebapp.push() } '

                         

                    

                } 

            }

        }  
    }
}
