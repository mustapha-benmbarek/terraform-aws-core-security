variable "core-key-pairs" {
  type = map(object({
    region     = optional(string)
    name       = string
    public-key = string
  }))
}
