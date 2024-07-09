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
| [azurerm_eventhub.eventhubs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_consumer_group.eventhub_consumergroup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eh_ns_name"></a> [eh\_ns\_name](#input\_eh\_ns\_name) | eh\_ns\_name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location for the Event Hub | `string` | n/a | yes |
| <a name="input_message_retention"></a> [message\_retention](#input\_message\_retention) | Specifies the  number of message\_retention | `number` | n/a | yes |
| <a name="input_partition_count"></a> [partition\_count](#input\_partition\_count) | Specifies the  number of partitions for a Kafka topic. | `number` | n/a | yes |
| <a name="input_proj_name"></a> [proj\_name](#input\_proj\_name) | Project name | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the services | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub_consumergroup_id"></a> [eventhub\_consumergroup\_id](#output\_eventhub\_consumergroup\_id) | n/a |
| <a name="output_eventhub_consumergroup_name"></a> [eventhub\_consumergroup\_name](#output\_eventhub\_consumergroup\_name) | n/a |
| <a name="output_eventhub_id"></a> [eventhub\_id](#output\_eventhub\_id) | n/a |
| <a name="output_eventhub_name"></a> [eventhub\_name](#output\_eventhub\_name) | n/a |
| <a name="output_eventhub_status"></a> [eventhub\_status](#output\_eventhub\_status) | n/a |
<!-- END_TF_DOCS -->