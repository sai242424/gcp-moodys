variable "project_id" {
  type        = string
  description = "The project ID to manage the Pub/Sub resources"
  default = "bq-poc-323317"
}

variable "topic" {
  type        = string
  description = "The Pub/Sub topic name"
  default = "bq-poc-notification"
}