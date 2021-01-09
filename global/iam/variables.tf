variable "user_name" {
  description = "Create IAM users with these names"
  type = list(string)
  default = ["neo", "clichy"]
}

variable "heroes" {
  description = "map"
  type = map(string)
  default = {
    neo = "hero"
    trin = "yo mama"
    morph = "mentor"
  }
}

variable "give_neo_cloudwatch_full_access" {
  description =  "If true, give Neo full access to Cloudwatch"
  type = bool
}