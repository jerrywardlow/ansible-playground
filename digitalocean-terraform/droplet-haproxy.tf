resource "digitalocean_droplet" "haproxy-web" {
    image = "ubuntu-16-04-x64"
    name = "haproxy-web"
    region = "sfo1"
    size = "512mb"
    private_networking = true
    ssh_keys = ["${var.ssh_id}"]

    connection {
        user = "root"
        type = "ssh"
        key_file = "~/.ssh/id_rsa"
        timeout = "2m"
    }
    
    provisioner "remote-exec" {
        script = "scripts/haproxy.sh"
    }
}
