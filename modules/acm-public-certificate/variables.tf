variable "core-acm-public-certificates" {
  type = map(object({
    region                    = optional(string)
    name                      = string
    domain-name               = string
    validation-method         = string
    key-algorithm             = string
    subject-alternative-names = optional(list(string))
  }))
}
