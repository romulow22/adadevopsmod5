# Jornada Digital CAIXA| Devops | #1148

## Projeto do Modulo 5: *Pipelines de CI e CD*

- Autor: Romulo Alves | c153824

## Descrição

Este projeto utiliza o Azure Pipelines para implementar pipelines de CI e CD para Infraestrutura como Codigo (IaC) usando terraform no Azure DevOps.

### Azure Pipelines
As pipelines são definidas em arquivos YAML no diretório raiz do projeto:

* **ads-docs-pipeline.yaml**: Esta pipeline é responsável pela geração de documentação para os módulos Terraform. Ela utiliza a ferramenta **terraform-docs** para gerar arquivos README.md para cada módulo Terraform. A pipeline remove os arquivos README.md antigos, gera novos e os comita no repositório.
  
* **ads-infra-pipeline.yaml**:  Esta pipeline é responsável pela execução de várias etapas do ciclo de vida do Terraform, incluindo validate, plan, apply, destroy, entre outros. Ela utiliza templates de pipeline localizados no diretório ***pipe_infra_templates***.

A pipeline tf-infra-pipeline foi criada de forma a ter todas as principais variáveis, (como nome do projeto, actions do terraform, nivel de log do terraform, etc) sendo passadas como parâmetro da pipeline para mais facil reutilização do módulo, mas é necessário que a preparação necessária seja ajustada de acordo.

### Templates de Pipeline

Os templates de pipeline são arquivos YAML que definem etapas reutilizáveis para as pipelines. Eles estão localizados no diretório ***pipe_infra_templates***. Cada arquivo corresponde a uma etapa específica do ciclo de vida do Terraform:

* tf_apply.yaml
* tf_applydestroy.yaml
* tf_checkov_scan.yaml
* tf_infracost.yaml
* tf_init.yaml
* tf_install.yaml
* tf_plan.yaml
* tf_plandestroy.yaml
* tf_replace_tokens.yaml
* tf_validate.yaml
* tf_workspace_select.yaml

### Variaveis de Pipeline

As variáveis de pipeline são definidas em arquivos YAML no diretório ***pipe_variables***. Estes arquivos incluem:

* docs_vars.yaml
* infra_vars.yaml

### Terraform

O código Terraform para a infraestrutura está localizado no diretório ***tf_infra***. Ele é organizado em módulos, cada um com seu próprio arquivo README.md gerado pela pipeline de documentação.

Neste modelo, os seguintes serviços podem ser provisionados:
- Azure Kubernetes Service (AKS)
- Azure Cache for Redis
- Azure Storage Account
- Azure Event Hub
- Azure Container Registry

### Scripts

O diretório scripts contém scripts auxiliares para o projeto, como New-StartupResources.ps1 para criação do Storage Account com as políticas necessárias onde o Tfstate ficará bem como o Key Vault onde será armazenado o PAT para que seja possivel atualizar o Git com a documentação gerada pelo terraform-docs.

### Variable Groups

Este projeto utiliza 3 variable groups com as seguitnes características:

  * **tf-infra-support**: variaveis para o funcionamento básico do projeto
  * **tf-[nome do projeto]-backend-[ambiente]**: variáveis com dados onde ficará o TfState e a service connection utilizada
  * **tf-[nome do projeto]-infra-[ambiente]**: variáveis de infra do projeto

### Enviromnets

Este projeto utiliza 2 environments nas tasks de apply para maior segurança e controle do provisionamento de infraestrutura:

* **tf-apply-destroy-[nome do projeto]-[ambiente]**: Este environment é utilizado para a execução de tasks de **destroy**, facilitando a gestão dos recursos removidos durante o ciclo de vida do desenvolvimento.
  
* **tf-apply-[nome do projeto]-[ambiente]**: Este environment é utilizado exclusivamente para a execução de tasks de **apply**, garantindo um ambiente controlado e seguro para a aplicação de mudanças na infraestrutura.

Os environments no Azure DevOps permitem um controle mais granular sobre a execução das pipelines, incluindo aprovações manuais, políticas de segurança e rastreamento de mudanças. 

Isso assegura que as modificações na infraestrutura sejam feitas de maneira segura e auditável.

## Estrutura do Projeto

```
PS C:\Users\User\repos\adadevopsmod5> tree /a
Folder PATH listing
C:.
+---.vscode
+---pipe_infra_templates
+---pipe_variables
+---scripts
\---tf_infra
    +---modules
    |   +---aks
    |   +---eventhub
    |   +---eventhubnamespace
    |   +---loganalytics
    |   +---redis
    |   +---resourcegroup
    |   +---storageaccount
    |   +---subnet
    |   \---vnet
    +---secrets
    \---tfvars
```

### Pré-requisitos

1. Uma subscrição na Azure e seu usario com perfil "Owner"
2. Uma organização no Azure DevOps com o perfil "Project Collection Administrator"
3. Um projeto nessa organização com o perfil "Project Administrator"

## Instruções

### Preparar o Ambiente

1. Importar o repositório de https://github.com/romulow22/adadevopsmod5.git

2. Criar a service connection na sua organização para a subscrição do tipo Azure Resource Manager > Service Principal Automatic com permissão para acessar todas as pipelines (sugestão de nome "sc-azsub"). Lembrando que necessário incluir a permissão de Owner para esta conta de serviço também. ([Referência](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops))

3. Criar um PAT na organização com permissão de Code Read & Write. ([Referência](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Linux))


4. Criar os recursos necessários para o projeto: 

   * Abrir um cmd PowerShell
  
   * No script New-StartupResources incluir as variavéis a seguir:
     - **subscriptionId**: o id da sua subscrição
     - **patoken**: O PAT criado no passo 3
     - **spobjectid**: O object id do service principal criado no passo 2

   * Executar o script
  
    ```
    .\scripts\New-StartupResources.ps1
    ```

   * Ação Esperada:
     - Criação do Storage Account com as políticas necessárias onde o Tfstate ficará
     - Criação do Key Vault onde será armazenado o PAT para que seja possivel atualizar o Git com a documentação gerada pelo terraform-docs

5. Criação dos Environments:

   * **tf-apply-destroy-siada-des**
   * **tf-apply-siada-des**

    **Atenção**: Incluir pelo menos 1 aprovador em cada Environment

6. Ajustes nos arquivos na pasta ***pipe_variables***:
   
   * caso você tenha colocado um outro nome para a service connection ou queira realizar algum ajuste, é preciso revisar os arquivos **docs_vars.yaml** e **infra_vars.yaml**
  
7. Criação das pipelines:

   * Selecionar os arquivos **ads-docs-pipeline.yaml** e **ads-infra-pipeline.yaml** do repositorio do projeto e salva-las sem rodar a pipeline
   * Renomear as pipelines para **tf-docs-pipeline** e **tf-infra-pipeline**, respectivamente


8. Criação dos Variable Groups:

* **tf-infra-support**:
   * **infracostapiKey**: ***colocar a apikey do infracost***
   * **keyvaultName**: "kv-docs-devops"
   * **secretsFilter**: "tfdocspatoken"

* **tf-siada-backend-des**:
  * **BackendAzureRmContainerName**: "tfstatecontainer"
  * **BackendAzureRmKey**: "des-infra.tfstate"
  * **BackendAzureRmResourceGroupName**: "rg-tfstate-siada"
  * **BackendAzureRmStorageAccountName**: "stgtfstatesiada001"

* **tf-siada-infra-des**:
  * **aks_dns_service_ip**: "10.0.3.10"
  * **aks_log_dc_interval**: "1m"
  * **aks_log_enableContainerLogV2**: true
  * **aks_log_ns_filtering_mode_for_dc**: "Off"
  * **aks_log_ns_for_dc**: ["kube-system","gatekeeper-system"]
  * **aks_log_streams**: ["Microsoft-ContainerLog", "Microsoft-ContainerLogV2", "Microsoft-KubeEvents", "Microsoft-KubePodInventory", "Microsoft-KubeNodeInventory", "Microsoft-KubePVInventory","Microsoft-KubeServices", "Microsoft-KubeMonAgentEvents", "Microsoft-InsightsMetrics", "Microsoft-ContainerInventory",  "Microsoft-ContainerNodeInventory", "Microsoft-Perf"]
  * **aks_max_node_count**: 2
  * **aks_min_node_count**: 1
  * **aks_node_vm_size**: "Standard_D2ds_v4"
  * **aks_service_cidr**: "10.0.3.0/24"
  * **aks_version**: "1.28.9"
  * **enable_module_aks**: true
  * **enable_module_eventhub_namespace**: true
  * **enable_module_eventhub_topics**: true
  * **enable_module_loganalytics**: true
  * **enable_module_redis**: false
  * **enable_module_rg**: true
  * **enable_module_storageaccount**: true
  * **enable_module_subnetaks**: true
  * **enable_module_subnetpvt**: true
  * **enable_module_vnet**: true
  * **env**: "des"
  * **kafka_eh_capacity**: 1
  * **kafka_eh_message_retention**: 1
  * **kafka_eh_partition_count**: 2
  * **kafka_eh_sku**: "Standard"
  * **kafka_eh_topics**: [ "antifraude" , "processamento" ]
  * **log_analytics**: { aks : "aks", resources : "resources" }
  * **log_analytics_workspace_sku**: "PerGB2018"
  * **log_anatytics_workspaces**: {aks = {retention_days = 30, solution_name = "ContainerInsights", solution_plan_map = {solution_plan1 = {product = "OMSGallery/ContainerInsights", publisher = "Microsoft" }}}, resources = {retention_days = 60, solution_name = "", solution_plan_map = {solution_plan1 = {product = "", publisher = "" }}}}
  * **project_name**: "siada"
  * **redis_capacity**: 1
  * **redis_enable_authentication**: true
  * **redis_enable_non_ssl_port**: true
  * **redis_enabled**: true
  * **redis_family**: "C"
  * **redis_maxmemory_policy**: "allkeys-lru"
  * **redis_public_network_access**: true
  * **redis_sku_name**: "Basic"
  * **region**: "brazilsouth"
  * **resource_groups**: { aks : "aks", resources : "resources", vnet : "vnet" }
  * **stg_access_tier**: "Hot"
  * **stg_account_kind**: "StorageV2"
  * **stg_account_tier**: "Standard"
  * **stg_allow_blob_public_access**: true
  * **stg_container_access_type**: "blob"
  * **stg_container_name**: "antifraudreports"
  * **stg_default_action**: "Allow"
  * **stg_file_share_name**: "fs-antifraudreports"
  * **stg_file_share_quota**: "10"
  * **stg_replication_type**: "LRS"
  * **subnet_aks**: ["10.0.0.0/23"]
  * **subnet_aks_security_rules**: [{name : "HTTP", priority : 100, direction : "Inbound", access : "Allow", protocol : "Tcp", source_port_ranges : ["0-65535"], destination_port_ranges : ["80", "443"], source_address_prefixes : ["0.0.0.0/0"], destination_address_prefixes : ["0.0.0.0/0"]}]
  * **subnet_pvt**: ["10.0.2.0/25"]
  * **subnet_pvt_security_rules**: [{name : "SSH", priority : 100, direction : "Inbound", access : "Allow", protocol : "Tcp", source_port_ranges : ["0-65535"], destination_port_ranges : ["22"], source_address_prefixes : ["0.0.0.0/0"], destination_address_prefixes : ["0.0.0.0/0"]}, {name : "HTTP", priority : 101, direction : "Inbound", access : "Allow", protocol : "Tcp", source_port_ranges : ["0-65535"], destination_port_ranges : ["80", "443"], source_address_prefixes : ["0.0.0.0/0"], destination_address_prefixes : ["0.0.0.0/0"]}, {name : "Custom", priority : 102, direction : "Inbound", access : "Allow", protocol : "Tcp", source_port_ranges : ["0-65535"], destination_port_ranges : ["8080-8090"], source_address_prefixes : ["0.0.0.0/0"], destination_address_prefixes : ["0.0.0.0/0"]}]
  * **vnet**: ["10.0.0.0/21"]

9. Conceder permissões das pipelines aos variable groups.

* **tf-siada-infra-des**: tf-infra-pipeline
* **tf-siada-backend-des**: tf-infra-pipeline
* **tf-infra-support**: tf-infra-pipeline e tf-docs-pipeline

### Executar o Ambiente

1. Na pipeline tf-infra-pipeline ajustar os valores dos parâmetros conforme a necessidade. Neste modelo utilizaremos:
   * **Action**: apply
   * **Projet name**: siada
   * **Environment**: des
   * **Terraform log level**: INFO

2. Aguardar o deploy da infraestrutura pelos logs e após a finalização com sucesso de todos os passos verificar no portal da Azure se todos os serviços foram provisionados corretamente.

3. Para destruir o ambiente, basta rodar uma nova pipeline com a Action ***apply_destroy***