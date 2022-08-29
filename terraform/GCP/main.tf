provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}


resource "google_compute_instance" "vm_instance" {
  count        = var.instance_count
  ## ambiente-nombre-index
  name         = "${terraform.workspace}-${var.name}-${count.index}"
  machine_type = var.machine_type


  boot_disk {
    initialize_params {
      image = "centos-8-v20200910"
    }
  }


  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }

  }

 

}


