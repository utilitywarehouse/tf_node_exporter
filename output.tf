output "node_exporter_id" {
  value = "${data.ignition_systemd_unit.node-exporter.id}"
}

output "static_metrics_id_list" {
  value = "${data.ignition_file.static-metrics.*.id}"
}
