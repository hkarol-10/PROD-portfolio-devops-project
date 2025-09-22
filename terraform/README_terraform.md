<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.37.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudflare_rules"></a> [cloudflare\_rules](#module\_cloudflare\_rules) | ./modules/cloudflare | n/a |
| <a name="module_compute"></a> [compute](#module\_compute) | ./modules/compute | n/a |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/storage | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_http_cidr"></a> [allowed\_http\_cidr](#input\_allowed\_http\_cidr) | Allowed CIDR for HTTP | `string` | `"0.0.0.0/0"` | no |
| <a name="input_allowed_ssh_cidr"></a> [allowed\_ssh\_cidr](#input\_allowed\_ssh\_cidr) | Allowed CIDR for SSH | `string` | n/a | yes |
| <a name="input_allowed_ssh_port"></a> [allowed\_ssh\_port](#input\_allowed\_ssh\_port) | Allowed port for SSH | `string` | n/a | yes |
| <a name="input_app_vm_name"></a> [app\_vm\_name](#input\_app\_vm\_name) | Name of the VM instance | `string` | n/a | yes |
| <a name="input_app_vm_size"></a> [app\_vm\_size](#input\_app\_vm\_size) | Size of application vm | `string` | `"e2-medium"` | no |
| <a name="input_blocked_http_cidr"></a> [blocked\_http\_cidr](#input\_blocked\_http\_cidr) | Blocked CIDR for HTTP | `string` | `"0.0.0.0/0"` | no |
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | Cloudflare API token | `string` | n/a | yes |
| <a name="input_cloudflare_zone_id"></a> [cloudflare\_zone\_id](#input\_cloudflare\_zone\_id) | Cloudflare Zone ID | `string` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size of the additional disk in GB | `number` | `10` | no |
| <a name="input_elk_disk_size"></a> [elk\_disk\_size](#input\_elk\_disk\_size) | Size of the additional disk in GB | `number` | `64` | no |
| <a name="input_elk_vm_name"></a> [elk\_vm\_name](#input\_elk\_vm\_name) | Name of the elk VM instance | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP Region | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP Zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_data_disk_id"></a> [app\_data\_disk\_id](#output\_app\_data\_disk\_id) | ID of the attached data disk |
| <a name="output_app_data_disk_snapshot"></a> [app\_data\_disk\_snapshot](#output\_app\_data\_disk\_snapshot) | Snapshot ID of the data disk |
| <a name="output_app_vm_public_ip"></a> [app\_vm\_public\_ip](#output\_app\_vm\_public\_ip) | Public IP of the VM |
<!-- END_TF_DOCS -->