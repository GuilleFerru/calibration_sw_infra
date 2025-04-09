terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

resource "docker_network" "calibration_net" {
  name = "calibration-net"
}

# Node-RED
resource "docker_container" "nodered" {
  name  = "nodered"
  image = "s7influx-nodered:latest"

  ports {
    internal = 1880
    external = 1880
  }

  volumes {
    host_path      = abspath("${path.module}/nodered_data")
    container_path = "/data"
  }

  networks_advanced {
    name = docker_network.calibration_net.name
  }

  restart = "always"
}


# InfluxDB 2.x
resource "docker_image" "influxdb" {
  name = "influxdb:2.7.11"
}

resource "docker_container" "influxdb" {
  name  = "influxdb"
  image = docker_image.influxdb.name
  ports {
    internal = 8086
    external = 8086
  }
  volumes {
    host_path      = abspath("${path.module}/influxdb_data")
    container_path = "/var/lib/influxdb2"
  }
  env = [
    "DOCKER_INFLUXDB_INIT_MODE=setup",
    "DOCKER_INFLUXDB_INIT_USERNAME=${var.influx_user}",
    "DOCKER_INFLUXDB_INIT_PASSWORD=${var.influx_pass}",
    "DOCKER_INFLUXDB_INIT_ORG=${var.influx_org}",
    "DOCKER_INFLUXDB_INIT_BUCKET=${var.influx_bucket}",
    "DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=${var.influx_token}"
  ]
  networks_advanced {
    name = docker_network.calibration_net.name
  }
  restart = "always"
}

# Grafana
resource "docker_image" "grafana" {
  name = "grafana/grafana"
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.grafana.name
  ports {
    internal = 3000
    external = 3000
  }
  volumes {
    host_path      = abspath("${path.module}/grafana_data")
    container_path = "/var/lib/grafana"
  }
  env = [
    "GF_SECURITY_ADMIN_USER=${var.grafana_user}",
    "GF_SECURITY_ADMIN_PASSWORD=${var.grafana_pass}"
  ]
  networks_advanced {
    name = docker_network.calibration_net.name
  }
  restart = "always"
}