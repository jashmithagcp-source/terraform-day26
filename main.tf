terraform {
  backend "gcs" {
    bucket = "jashmitha-terraform-state-2026"
    prefix = "terraform-day26"
  }



  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "terraform_bucket" {
  name                        = "jashmitha-terraform-day8-2026"
  location                    = "US-CENTRAL1"
  uniform_bucket_level_access = true
}

resource "google_compute_subnetwork" "devops_subnet" {
  name          = "jashmitha-devops-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = module.network.network_id
}

resource "google_compute_instance" "devops_vm" {
  name                      = "jashmitha-devops-vm"
  machine_type              = var.machine_type
  allow_stopping_for_update = true
  zone                      = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = module.network.network_id
    subnetwork = google_compute_subnetwork.devops_subnet.id

    access_config {}
  }
}

module "network" {
  source       = "./modules/network"
  network_name = "jashmitha-devops-vpc"
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "jashmitha-allow-ssh"
  network = module.network.network_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "jashmitha-allow-http"
  network = module.network.network_id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
