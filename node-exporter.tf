data "ignition_file" "static-metrics" {
  count      = length(var.static_metrics)
  mode       = 420
  filesystem = "root"
  path       = "${var.collector_dir}/${element(keys(var.static_metrics), count.index)}"

  content {
    content = element(values(var.static_metrics), count.index)
  }
}

data "ignition_systemd_unit" "node-exporter" {
  name = "node-exporter.service"

  content = templatefile("${path.module}/templates/node-exporter.service",
    {
      node_exporter_image_url = var.node_exporter_image_url
      node_exporter_image_tag = var.node_exporter_image_tag
      collector_dir           = var.collector_dir
    }
  )
}
