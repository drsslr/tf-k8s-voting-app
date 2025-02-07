variable "app" {
  description = "Name of the application, also used for namespaces etc."
  type        = string
  default     = "app"
}

variable "limit_cpu" {
  description = "Default limit value for CPU resources."
  type        = string
  default     = "500m"
}

variable "limit_mem" {
  description = "Default limit value for memory resources."
  type        = string
  default     = "256Mi"
}

variable "request_cpu" {
  description = "Default request value for CPU resources."
  type        = string
  default     = "250m"
}

variable "request_mem" {
  description = "Default request value for memory resources."
  type        = string
  default     = "64Mi"
}