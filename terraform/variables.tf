variable "project_id" {}
variable "region" {default = "us-central1"}
variable "zone" {default = "us-central1-a"}
variable "public_key_path" {
  description = "Path to public SSH key"
}