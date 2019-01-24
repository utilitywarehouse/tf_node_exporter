# tf_node_exporter

This terraform module generates ignition configuration to deploy node-exporter as systemd unit. It supports specifying static metrics via tf maps.

## Input Variables

The input variables are documented in their description and it's best to refer to [variables.tf](variables.tf).

## Ouputs

- `node_exporter_id` - systemd unit file id
- `static_metrics_id_list` - list of file ids that contain static metrics definitions

## Usage

Simply as:

```hcl
module "node-exporter" {
  source = "github.com/utilitywarehouse/tf_node_exporter"
}

data "ignition_config" "gobgp" {

  systemd = [
    "${data.ignition_systemd_unit.some_unit.id}",
    "${module.node-exporter.node_exporter_id}",
  ]

  files = [
      "${data.ignition_file.some_file.id}",
  ]
}

```

Using collector and static metrics:

```hcl
variable "node-exporter-machine-roles" {
  default = {
    "machine_role.prom" = "machine_role{role=\"mybox\"} 1\n"
  }
}

module "node-exporter" {
  source         = "github.com/utilitywarehouse/tf_node_exporter"
  collector_dir  = "/etc/prom-text-collectors/"
  static_metrics = "${var.gobgp-node-exporter-machine-roles}"
}

data "ignition_config" "gobgp" {

  systemd = [
    "${data.ignition_systemd_unit.some_unit.id}",
    "${module.node-exporter.node_exporter_id}",
  ]

  files = ["${concat(
    list(
      "${data.ignition_file.some_file.id}",
    ),
    "${module.node-exporter.static_metrics_id_list}",
  )}"]
}
```
