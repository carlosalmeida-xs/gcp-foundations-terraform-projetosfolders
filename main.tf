provider "google" {
  project = "devops-iac-368216"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "${file("serviceaccount.yaml")}"
}
resource "google_folder" "financeiro" {
  display_name = "financeiro"
  parent       = "organizations/319569038597"
}
resource "google_folder" "salesforce" {
  display_name = "salesforce"
  parent = google_folder.financeiro.name
}
resource "google_folder" "desenvolvimento" {
  display_name = "desenvolvimento"
  parent = google_folder.salesforce.name
}
resource "google_folder" "producao" {
  display_name = "producao"
  parent       = google_folder.salesforce.name
}
resource "google_project" "devops-iac-salesforce-dev" {
  name       = "salesforce-dev"
  project_id = "devops-iac-salesforce-dev"
  folder_id  = google_folder.desenvolvimento.name
  auto_create_network = false
  billing_account = "01D48F-4BFE7E-B8EECF"
}