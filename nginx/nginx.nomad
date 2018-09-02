# NIH
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
        volumes = [
          "custom/index.html:/usr/share/nginx/html/index.html"
        ]
      }
      artifact = {
        source = "https://raw.githubusercontent.com/ishworgurung/nomad-jobs/master/nginx/index.html"
        mode = "file"
        destination = "custom/index.html"
        options {
          checksum = "md5:745ee1cea3f7c0efcec7b01872dc13b8"
        }
      }
      service {
        name = "nginx"
        tags = ["edge","urlprefix-/hello strip=/hello"]
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
            mbits = 100
            port "http" {
                 static = "9990"
            }
        }
      }
    }
  }
}
