pipeline {

    agent any

    stages{
        stage("test"){
            steps {
                sh( script: 'echo "test test" ', returnStdout: true)
                sh( script: 'ls ', returnStdout: true)
            }
        }

        stage("terraform init"){
            steps{
                ansiColor('xterm'){
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'azure_service_principal',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                    ),
                    string(credentialsId: 'infra_state_access_key', variable: 'ARM_ACCESS_KEY')
                    ]) {
                        sh """
                        echo "Initialising Terraform"
                        terraform init -backend-config="access_key=$ARM_ACCESS_KEY"
                        """
                    }
                }
            }
        }

        stage("Terraform plan"){
            steps{
                ansiColor('xterm'){
                    withCredentials([azureServicePrincipal(
                        credentialsId: 'azure_service_principal',
                        subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                        clientIdVariable: 'ARM_CLIENT_ID',
                        clientSecretVariable: 'ARM_CLIENT_SECRET',
                        tenantIdVariable: 'ARM_TENANT_ID'
                    )
                    ]) {
                        sh """
                        echo "Terraform Plan Creation"
                        terraform plan
                        """
                    }
                }
            }
        }
    }

}