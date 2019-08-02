job "vmck" {
  datacenters = ["dc1"]
  type = "service"

  group "vmck" {
    task "vmck" {
      driver = "docker"
      config {
        image = "vmck/vmck"
        volumes = [
          "/opt/vmck/data:/opt/vmck/data",
        ]
        port_map {
          http = 8000
        }
        labels {
          liquid_task = "vmck"
        }
      }
      template {
        data = <<-EOF
          SECRET_KEY = "TODO:ChangeME!!!"
          HOSTNAME = "*"
          SSH_USERNAME = "vagrant"
          CONSUL_URL = "http://10.42.1.1:8500"
          NOMAD_URL = "http://10.42.1.1:4646"
          BACKEND = "qemu"
          QEMU_CPU_MHZ = 3000
          EOF
          destination = "local/vmck.env"
          env = true
      }
      template {
        data = <<-EOF
          QEMU_IMAGE_PATH_PREFIX = "http://10.42.1.1:10000"
          EOF
          destination = "local/vmck-imghost.env"
          env = true
      }
      resources {
        memory = 450
        cpu = 350
        network {
          port "http" {
            static = 9990
          }
        }
      }
      service {
        name = "vmck"
        port = "http"
        check {
          name = "vmck alive on http"
          initial_status = "critical"
          type = "http"
          path = "/v0/"
          interval = "5s"
          timeout = "5s"
        }
      }
    }
  }
}
