/*Resource creation: ACM Public Certificate*/
resource "aws_acm_certificate" "this" {
  for_each                  = var.core-acm-public-certificates
  domain_name               = each.value.domain-name
  subject_alternative_names = each.value.subject-alternative-names
  validation_method         = each.value.validation-method
  key_algorithm             = each.value.key-algorithm
  tags = {
    Name = each.key
  }
  lifecycle {
    create_before_destroy = true
  }
}
