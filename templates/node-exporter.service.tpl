[Unit]
Description=Prometheus node_exporter
Requires=docker.socket
After=docker.socket
[Service]
ExecStartPre=-/bin/sh -c 'docker kill "$(docker ps -q --filter=name=%p_)"'
ExecStartPre=-/bin/sh -c 'docker rm "$(docker ps -q --filter=name=%p_)"'
ExecStartPre=-/usr/bin/mkdir -p /etc/prom-text-collectors
# /run/dbus/system_bus_socket mount for --collector.systemd
ExecStart=/bin/sh -c "\
    /usr/bin/docker run --rm \
      --name %p_$(uuidgen) \
      -p 9100:9100 \
      --net=host \
      --pid=host \
      -v /:/host:ro,rslave \
      -v /run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
      ${node_exporter_image_url}:${node_exporter_image_tag} \
        --path.rootfs /host ${collector_dir == "" ? "" : "--collector.textfile.directory=/host${collector_dir}"} ${extra_flags == "" ? "" : "${extra_flags}"}"
ExecStop=-/bin/sh -c 'docker stop -t 3 "$(docker ps -q --filter=name=%p_)"'
Restart=on-failure
RestartSec=60
[Install]
WantedBy=multi-user.target
