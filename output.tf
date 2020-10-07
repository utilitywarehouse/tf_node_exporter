output "node_exporter_rendered" {
  value = data.ignition_systemd_unit.node-exporter.rendered
}

output "static_metrics_rendered_list" {
  value = data.ignition_file.static-metrics.*.rendered
}
