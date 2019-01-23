output "node_exporter_id" {
  value = "${data.ignition_systemd_unit.node-exporter.id}"
}

output "machine_roles_id_list" {
  value = "${data.ignition_file.machine-role.*.id}"
}
