# tflint-ignore: terraform_unused_declarations
variable "host" {
  description = "traefik hostname"
  type        = string
  default     = ""
}

variable "basic_auth_username" {
  description = "traefik basic auth username"
  type        = string
  default     = ""
}

variable "basic_auth_password" {
  description = "traefik basic auth password"
  type        = string
  default     = ""
}

variable "dashboard_ingress_yaml_body" {
  description = "The yaml file content to use to create Dashboard ingress"
  type        = string
  default     = ""
}

variable "values_yaml_body" {
  description = "The yaml file content to use with helm chart"
  type        = string
  default     = ""
}

variable "chart_version" {
  description = "The helm chart version to use"
  type        = string
  default     = "10.20.1"
}

variable "enable_websecure" {
  description = "If true it will adds the 'websecure' entryPoint into Traefik"
  type        = bool
  default     = false
}
