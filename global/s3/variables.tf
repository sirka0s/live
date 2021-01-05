#Setting variable for rest of script
variable "server_port" {
  description = "The port server will use for HTTP requests"
  type        = number 
  default     = 8081
}