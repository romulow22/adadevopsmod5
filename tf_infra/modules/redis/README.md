<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.diag_redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_redis_cache_access_policy_assignment.redis_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache_access_policy_assignment) | resource |
| [azurerm_role_assignment.redis_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_identity_principal_id"></a> [aks\_identity\_principal\_id](#input\_aks\_identity\_principal\_id) | aks\_identity\_principal\_id | `string` | n/a | yes |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The size of the Redis cache | `number` | n/a | yes |
| <a name="input_enable_authentication"></a> [enable\_authentication](#input\_enable\_authentication) | (Optional) If set to false, the Redis instance will be accessible without authentication. Defaults to true. | `bool` | n/a | yes |
| <a name="input_enable_non_ssl_port"></a> [enable\_non\_ssl\_port](#input\_enable\_non\_ssl\_port) | Specifies whether the non-ssl Redis server port (6379) is enabled | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_family"></a> [family](#input\_family) | The family of the SKU to use | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the Redis instance will be created | `string` | n/a | yes |
| <a name="input_maxmemory_policy"></a> [maxmemory\_policy](#input\_maxmemory\_policy) | The eviction policy for the Redis cache | `string` | `"allkeys-lru"` | no |
| <a name="input_proj_name"></a> [proj\_name](#input\_proj\_name) | project Name | `string` | n/a | yes |
| <a name="input_public_network_access"></a> [public\_network\_access](#input\_public\_network\_access) | Whether or not public network access is allowed for this Redis Cache. true means this resource could be accessed by both public and private endpoint. false means only private endpoint access is allowed. Defaults to true. | `bool` | n/a | yes |
| <a name="input_rg_id"></a> [rg\_id](#input\_rg\_id) | resource group id | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU of Redis cache to use | `string` | n/a | yes |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | workspace\_id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_redis_host"></a> [redis\_host](#output\_redis\_host) | n/a |
| <a name="output_redis_logdiagnostics_id"></a> [redis\_logdiagnostics\_id](#output\_redis\_logdiagnostics\_id) | n/a |
| <a name="output_redis_logdiagnostics_name"></a> [redis\_logdiagnostics\_name](#output\_redis\_logdiagnostics\_name) | n/a |
| <a name="output_redis_port"></a> [redis\_port](#output\_redis\_port) | n/a |
| <a name="output_redis_primary_key"></a> [redis\_primary\_key](#output\_redis\_primary\_key) | n/a |
| <a name="output_redis_ssl_port"></a> [redis\_ssl\_port](#output\_redis\_ssl\_port) | n/a |
<!-- END_TF_DOCS -->