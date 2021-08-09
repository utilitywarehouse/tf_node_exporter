variable "collector_dir" {
  description = "Location of the collector directory"
  default     = "/etc/prom-text-collectors/"
}

// static_metrics map
// Should follow the pattern: "filename" = "content"
// e.t.c.
// default = {
//  "machine_role.prom" = "machine_role{role=\"mybox\"} 1\n"
// }
variable "static_metrics" {
  description = "Map of static metrics in the pattern <filename> = <content>"
  type        = map(string)
  default     = {}
}

variable "node_exporter_image_url" {
  description = "Where to get the node_exporter image from."
  default     = "quay.io/prometheus/node-exporter"
}

variable "node_exporter_image_tag" {
  description = "The version of the node_exporter image to use."
  default     = "v1.2.2"
}
