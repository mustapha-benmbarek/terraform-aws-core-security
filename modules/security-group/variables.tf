variable "core-security-groups" {
  type = map(object({
    region      = optional(string)
    name        = string
    description = optional(string)
    vpc-name    = string

    ingress-rules = optional(list(object({
      rule-protocol              = optional(string)
      rule-port-from             = optional(number)
      rule-port-to               = optional(number)
      rule-source-ipv4           = optional(string)
      rule-source-ipv6           = optional(string, "")
      rule-source-prefix-list    = optional(string, "")
      rule-source-security-group = optional(string, "")
    })), [])

    egress-rules = optional(list(object({
      rule-number                     = optional(number)
      rule-protocol                   = optional(string)
      rule-port-from                  = optional(number)
      rule-port-to                    = optional(number)
      rule-destination-ipv4           = optional(string)
      rule-destination-ipv6           = optional(string, "")
      rule-destination-prefix-list    = optional(string, "")
      rule-destination-security-group = optional(string, "")
    })), [])
  }))
}
