variable "collector_dir" {
  description = "Location of the collector directory"
  default     = ""
}

// machine_roles map
// Should follow the pattern: "filename" = "content"
// e.t.c.
// default = {
//  "machine_role.prom" = "machine_role{role=\"mybox\"} 1\n"
// }
variable "machine_roles" {
  description = "Map of machine roles in the pattern <filename> = <content>"
  type        = "map"
  default     = {}
}

variable "node_exporter_image_url" {
  description = "Where to get the node_exporter image from."
  default     = "quay.io/prometheus/node-exporter"
}

variable "node_exporter_image_tag" {
  description = "The version of the node_exporter image to use."
  default     = "v0.17.0"
}
