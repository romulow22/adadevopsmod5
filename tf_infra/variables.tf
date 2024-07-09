variable "enable_module_rg" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_vnet" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_subnetaks" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_loganalytics" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_redis" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_eventhub_namespace" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_eventhub_topics" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_storageaccount" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_aks" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "enable_module_subnetpvt" {
  description = "Flag to turn on or off the module"
  type        = bool
  default     = true
}

variable "resource_groups" {
  description = "Map of resource groups to create"
  type        = map(string)
}

# region
variable "region" {
  type        = string
  description = "Region"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

# Virtual Network CIDR
variable "vnet" {
  type        = list(string)
  description = "Virtual Network CIDR"
}

# subnet CIDRs
variable "aks_subnet" {
  type        = list(string)
  description = "AKS Subnet CIDRs"
}

# subnet CIDRs
variable "pvt_subnet" {
  type        = list(string)
  description = "Private Subnet CIDRs"
}

variable "pvt_subnet_security_rules" {
  description = "A list of security rules to be created."
  type = list(object({
    name                          = string
    priority                      = number
    direction                     = string 
    access                        = string
    protocol                      = string
    source_port_ranges            = list(string)
    destination_port_ranges       = list(string)
    source_address_prefixes       = list(string)
    destination_address_prefixes  = list(string)
    }))
}

variable "aks_subnet_security_rules" {
  description = "A list of security rules to be created."
  type = list(object({
    name                          = string
    priority                      = number
    direction                     = string 
    access                        = string
    protocol                      = string
    source_port_ranges            = list(string)
    destination_port_ranges       = list(string)
    source_address_prefixes       = list(string)
    destination_address_prefixes  = list(string)
    }))
}


# environment
variable "environment" {
  type        = string
  description = "Environment"
  validation {
    condition     = contains(["des", "tqs", "prd"], var.environment)
    error_message = "Por favor escolha entre des, tqs ou prd"
  }
}

# max node count 
variable "aks_max_node_count" {
  type        = number
  description = "Maximum node count for worker node"
}

# min node count 
variable "aks_min_node_count" {
  type        = number
  description = "Minimum node count for worker node"
}

# size of worker node
variable "aks_node_vm_size" {
  type        = string
  description = "Size of worker node"
}

variable "aks_version" {
  type        = string
  description = "Version of the AKS"
}

variable "aks_service_cidr" {
  type        = string
  description = "AKS Service CIDRs"
}

variable "aks_dns_service_ip" {
  type        = string
  description = "AKS DNS Service IP"
}

variable "redis_capacity" {
  type        = number
  description = "The size of the Redis cache"
}

variable "redis_family" {
  type        = string
  description = "The family of the SKU to use"
}

variable "redis_sku_name" {
  type        = string
  description = "The SKU of Redis cache to use"
}

variable "redis_enable_non_ssl_port" {
  type        = bool
  description = "Specifies whether the non-ssl Redis server port (6379) is enabled"
}

variable "redis_maxmemory_policy" {
  type        = string
  description = "The eviction policy for the Redis cache"
}

variable "redis_public_network_access" {
  description = "Whether or not public network access is allowed for this Redis Cache."
  type        = bool
}

variable "redis_enable_authentication" {
  description = "If set to false, the Redis instance will be accessible without authentication."
  type        = bool
}

// ==========================  azure event hubs variables =========================
variable "kafka_eh_sku" {
  description = "Defines which tier to use for the Event Hub."
  type        = string
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.kafka_eh_sku)
    error_message = "The SKU of the Event Hub is invalid."
  }
}
variable "kafka_eh_capacity" {
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
  type        = number
}
variable "kafka_eh_partition_count" {
  description = "Specifies the number of partitions for a Kafka topic."
  type        = number
}
variable "kafka_eh_message_retention" {
  description = "Specifies the number of days to retain messages."
  type        = number
}

variable "kafka_eh_topics" {
  description = "An array of strings that indicates values of Kafka topics."
  type        = list(string)
}

// ========================== storage account variables ==========================
variable "storage_account_kind" {
  description = "Specifies the account kind of the storage account"
  type        = string
  validation {
    condition     = contains(["Storage", "StorageV2", "BlobStorage", "BlockBlobStorage", "FileStorage"], var.storage_account_kind)
    error_message = "The account kind of the storage account is invalid."
  }
}
variable "storage_access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts."
  type        = string
  validation {
    condition     = contains(["Hot", "Cool"], var.storage_access_tier)
    error_message = "The access tier of the storage account is invalid."
  }
}
variable "storage_account_tier" {
  description = "Specifies the account tier of the storage account"
  type        = string
  validation {
    condition     = contains(["Standard", "Premium"], var.storage_account_tier)
    error_message = "The account tier of the storage account is invalid."
  }
}
variable "storage_allow_blob_public_access" {
  description = "Specifies the public access type for blob storage"
  type        = bool
}
variable "storage_replication_type" {
  description = "Specifies the replication type of the storage account"
  type        = string
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.storage_replication_type)
    error_message = "The replication type of the storage account is invalid."
  }
}

variable "storage_default_action" {
  description = "Allow or disallow public access to all blobs or containers in the storage accounts."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the Container within the Blob Storage Account where Kafka messages should be captured."
  type        = string
}
variable "storage_file_share_name" {
  description = "The name of the File Share within the Storage Account where files should be stored."
  type        = string
}

variable "storage_file_share_quota" {
  description = "The maximum size of the file share, in gigabytes."
  type        = number
}

variable "storage_container_access_type" {
  description = "The Access Level configured for this Container."
  type        = string
}

// ========================== log analytics variables ==========================
variable "log_analytics_workspace_sku" {
  description = "Specifies the SKU of the log analytics workspace."
  type        = string
  validation {
    condition     = contains(["Free", "Standalone", "PerNode", "PerGB2018"], var.log_analytics_workspace_sku)
    error_message = "The log analytics SKU is incorrect."
  }
}

variable "log_anatytics_workspaces" {
  description = "A map of workspaces and their associated solutions."
  type = map(object({
    retention_days    = number
    solution_name     = string
    solution_plan_map = map(object({
      product   = string
      publisher = string
    }))
  }))
}

variable "log_analytics" {
  description = "Map of log analytics per resource group to create."
  type        = map(string)
}

// ========================== log analytics variables for AKS ==========================
variable "aks_log_data_collection_interval" {
  type        = string
  description = "Log data collection interval for AKS."
  default     = "1m"
}

variable "aks_log_namespace_filtering_mode_for_data_collection" {
  type        = string
  description = "Log namespace filtering mode for data collection in AKS."
  default     = "Off"
}

variable "aks_log_namespaces_for_data_collection" {
  type        = list(string)
  description = "Namespaces for log data collection in AKS."
  default     = ["kube-system", "gatekeeper-system", "azure-arc"]
}

variable "aks_log_enableContainerLogV2" {
  type        = bool
  description = "Enable Container Log V2 for AKS."
  default     = true
}

variable "aks_log_streams" {
  type        = list(string)
  description = "Log streams for AKS."
  default     = ["Microsoft-ContainerLog", "Microsoft-ContainerLogV2", "Microsoft-KubeEvents", "Microsoft-KubePodInventory", "Microsoft-KubeNodeInventory", "Microsoft-KubePVInventory", "Microsoft-KubeServices", "Microsoft-KubeMonAgentEvents", "Microsoft-InsightsMetrics", "Microsoft-ContainerInventory", "Microsoft-ContainerNodeInventory", "Microsoft-Perf"]
}