pipeline {

    agent any

    environment {
        ENV_NAME = "${env.BRANCH_NAME == "prod" ? "prod" : "dev"}"
        TERRAFORM_DIR = "terraform"
    }

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
                        dir(env.TERRAFORM_DIR) {
                                sh """
                            echo "Initialising Terraform"
                            terraform init -backend-config="access_key=$ARM_ACCESS_KEY" -var-file="./vars/${ENV_NAME}.tfvars"
                            """
                        }
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
                        dir(env.TERRAFORM_DIR) {
                            sh """
                            echo "Terraform Plan Creation"
                            terraform plan -var-file="./vars/${ENV_NAME}.tfvars"
                            """
                        }
                    }
                }
            }
        }
    }

}