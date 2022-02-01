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
        CI = true
        ARTIFACTORY_ACCESS_TOKEN = credentials('artifactory-access-token')
    }
    agent none
    stages {    
         // stage( ' permission ' ){
      //   agent any

        //    steps {
              
        //        sh "sudo chown root:jenkins /run/docker.sock"
         //   }

     //   } 
            
         //   stage( ' Build - Maven package ' ){
            //     agent any
              //       steps {
                //         script {
                             
                  //           sh 'mvn clean -Denv.MYSQL_SERVER_IP=${MYSQL_SERVER_IP}  -Denv.MYSQL_USERNAME=${MYSQL_USERNAME} -Denv.MYSQL_PASSWORD=${MYSQL_PASSWORD} package  -P MySQL '
                          
                   //       }
                    //    }
     //   }
      //  stage ( 'Run JMeter Test' ){
        //    agent any
          //  steps {  sh "/home/devops/apache-jmeter-5.4.3/bin/jmeter -Jjmeter.save.saveservice.output_format=xml  -n -t src/test/jmeter/petclinic_test_plan.jmx    -l  test.jtl"
        //step([$class: 'ArtifactArchiver', artifacts: 'test.jtl'])
          //         perfReport 'test.jtl'
            //   }
        //}
        stage ( 'archive artifact war' ){
            agent any
            steps {
                
                archiveArtifacts artifacts: 'target/petclinic.war'}}
        stage ('upload to artifactory'){
            agent { 
                docker {
                    image 'docker.bintray.io/jfrog/artifactory-oss'
                    reuseNode true
                }
           }
          
            steps {
                   script {
                sh 'jfrog rt upload --url http://localhost:8082 --access-token ${ARTIFACTORY_ACCESS_TOKEN} target/petclinic.war java-web-app/ '
                   }}
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
