variable "region" {
  description = "This is the cloud hosting region where your webapp will be deployed."
}


variable "project" {
    description = "El proyecto donde vamos a dejar las machines"
}

variable "zone" {
    description = "La zona de google"
}

variable "name" { 
    description = "El nombre de la maquina que vamos a crear" 
}

variable "machine_type" { 
    description = "El modelo maquina de acuedo a los estandares de GCP"
}

variable "instance_count" { 
    description = "cantidad de maquinas a crear"
}



