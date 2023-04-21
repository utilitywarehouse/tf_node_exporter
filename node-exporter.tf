data "ignition_file" "static-metrics" {
  count = length(var.static_metrics)
  mode  = 420
  # Trim trailing / in collector dir if exists. Otherwise a double slash // will
  # make terrafrom raise a "path is not simplified" error.
  path = "${trimsuffix(var.collector_dir, "/")}/${element(keys(var.static_metrics), count.index)}"

  content {
    content = element(values(var.static_metrics), count.index)
  }
}

data "ignition_systemd_unit" "node-exporter" {
  name = "node-exporter.service"

  content = templatefile("${path.module}/templates/node-exporter.service.tpl",
    {
      node_exporter_image_url = var.node_exporter_image_url
      node_exporter_image_tag = var.node_exporter_image_tag
      collector_dir           = var.collector_dir
      extra_flags             = var.extra_flags
    }
  )
}
