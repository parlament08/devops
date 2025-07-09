provider "google" {
  project = var.project_id
  region = var.region
  zone = var.zone
}
resource "google_compute_network" "default" {
  name = "vm-network"
}
resource "google_compute_firewall" "allow-ssh-http" {
  name    = "allow-ssh-http"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports = ["22", "80", "443", "3000", "5050", "9090", "9100"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  target_tags   = ["devops", "allow5050"]
}

data "google_compute_image" "ubuntu" {
  family = "ubuntu-minimal-2504-amd64"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "default" {
  machine_type = "f1-micro"
  name         = "devops-vm"
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }
  network_interface {
    network = google_compute_network.default.name
    access_config {

    }
  }

  metadata = {
    ssh-keys = "devops:${file(var.public_key_path)}"
  }

  tags = ["http-server", "https-server", "allow5050", "devops"]
}