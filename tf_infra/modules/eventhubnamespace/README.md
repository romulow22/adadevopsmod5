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
| [azurerm_eventhub_namespace.eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace_authorization_rule.eventhub_namespace_auth_listen](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_authorization_rule.eventhub_namespace_auth_manage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_eventhub_namespace_authorization_rule.eventhub_namespace_auth_send](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_monitor_diagnostic_setting.diag_eventhub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_role_assignment.event_hubs_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_identity_principal_id"></a> [aks\_identity\_principal\_id](#input\_aks\_identity\_principal\_id) | aks\_identity\_principal\_id | `string` | n/a | yes |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | capacity | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location for the Event Hub | `string` | n/a | yes |
| <a name="input_proj_name"></a> [proj\_name](#input\_proj\_name) | Project name | `string` | n/a | yes |
| <a name="input_rg_id"></a> [rg\_id](#input\_rg\_id) | resource group id | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | SKU tier | `string` | n/a | yes |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | workspace\_id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub_logdiagnostics_id"></a> [eventhub\_logdiagnostics\_id](#output\_eventhub\_logdiagnostics\_id) | n/a |
| <a name="output_eventhub_logdiagnostics_name"></a> [eventhub\_logdiagnostics\_name](#output\_eventhub\_logdiagnostics\_name) | n/a |
| <a name="output_eventhub_namespace_conn_string_lister"></a> [eventhub\_namespace\_conn\_string\_lister](#output\_eventhub\_namespace\_conn\_string\_lister) | n/a |
| <a name="output_eventhub_namespace_conn_string_manage"></a> [eventhub\_namespace\_conn\_string\_manage](#output\_eventhub\_namespace\_conn\_string\_manage) | n/a |
| <a name="output_eventhub_namespace_conn_string_send"></a> [eventhub\_namespace\_conn\_string\_send](#output\_eventhub\_namespace\_conn\_string\_send) | n/a |
| <a name="output_eventhub_namespace_id"></a> [eventhub\_namespace\_id](#output\_eventhub\_namespace\_id) | n/a |
| <a name="output_eventhub_namespace_name"></a> [eventhub\_namespace\_name](#output\_eventhub\_namespace\_name) | n/a |
<!-- END_TF_DOCS -->