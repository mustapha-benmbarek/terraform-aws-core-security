variable "core-vpcs" {}
variable "core-vpc-subnets" {}
variable "core-network-acls" {
  type = map(object({
    region   = optional(string)
    vpc-name = string
    subnets  = optional(list(string))

    ingress-rules = optional(list(object({
      rule-number      = optional(number)
      rule-protocol    = optional(string)
      rule-port-from   = optional(number, 0)
      rule-port-to     = optional(number, 0)
      rule-source-ipv4 = optional(string)
      rule-source-ipv6 = optional(string, "")
      rule-action      = optional(string, "allow")
    })), [])

    egress-rules = optional(list(object({
      rule-number           = optional(number)
      rule-protocol         = optional(string)
      rule-port-from        = optional(number, 0)
      rule-port-to          = optional(number, 0)
      rule-destination-ipv4 = optional(string)
      rule-destination-ipv6 = optional(string, "")
      rule-action           = optional(string, "allow")
    })), [])
  }))
}
