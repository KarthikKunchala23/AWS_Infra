# variable "github_oauth_token" {
#   description = "token for github"
#   type = string
#   sensitive = true
# }

variable "sg_ports" {
  type = list(number)
  default = [22, 443, 80, 8080]
}