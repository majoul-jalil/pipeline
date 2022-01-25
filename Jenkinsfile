pipeline{
    agent none
    stages {    
             
            stage( ' Build - Maven package ' ){
                 agent any
                     steps {
                         script {
                           
                             sh ' mvn  clean install '
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
    }
}
