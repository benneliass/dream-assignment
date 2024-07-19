variable "region" {
  description = "AWS Region"
  type        = string
}

variable "ami" {
  description = "AWS AMI"
  type        = string
}

variable "instance_type" {
  description = "AWS Instance type"
  type        = string
}

variable "instance_name" {
  description = "AWS EC2 Instance name"
  type        = string
}

variable "key_name" {
  description = "AWS SSH key-pair name"
  type        = string
}

variable "dockerhub_username" {
  description = "DockerHub username"
  type        = string
}

variable "dockerhub_token" {
  description = "DockerHub token"
  type        = string
}

variable "dockerhub_repository" {
  description = "DockerHub repository"
  type        = string
}

variable "dockerhub_registry" {
  description = "DockerHub registry"
  type        = string
}

variable "dockerhub_tag" {
  description = "DockerHub image tag"
  type        = string
  default     = "latest"
}

variable "app_port" {
  description = "Port on which the Flask app will run"
  type        = number
  default     = 80
}
