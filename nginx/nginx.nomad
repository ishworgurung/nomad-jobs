job "nginx" {
  datacenters = ["dc1"]
  group "nginx" {
    count = 4
    task "nginx" {
      driver = "docker"
      config {
        image = "nginx:latest"
        port_map {
          http = 80
        }
      }
      artifact = {
        source = "https://raw.githubusercontent.com/ishworgurung/nomad-jobs/master/nginx/index.html"
        destination = "/usr/share/nginx/html/index.html"
      }
      service {
        name = "nginx"
        tags = ["global"]
        port = "http"
        check {
          name     = "nginx alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
      resources {
        cpu = 250
        memory = 64
        network {
            mbits = 10
            port "http" {
                 static = "9999"
            }
        }
      }
    }
  }
}
