/*Resource creation: Security Group*/
resource "aws_security_group" "this" {
  for_each    = var.core-security-groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = var.core-vpcs[each.value.vpc-name].id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  dynamic "ingress" {
    for_each = each.value.ingress-rules
    content {
      description      = ingress.value["rule-description"]
      protocol         = lower(ingress.value["rule-protocol"])
      from_port        = ingress.value["rule-port-from"]
      to_port          = ingress.value["rule-port-to"]
      cidr_blocks      = (ingress.value["rule-source-ipv4"] != "" ? ingress.value["rule-source-ipv4"] : null)
      ipv6_cidr_blocks = (ingress.value["rule-source-ipv6"] != "" ? ingress.value["rule-source-ipv6"] : null)
      prefix_list_ids  = (ingress.value["rule-source-prefix-list"] != "" ? ingress.value["rule-source-prefix-list"] : null)
      security_groups  = (ingress.value["rule-source-security-group"] != "" ? ingress.value["rule-source-security-group"] : null)
    }
  }

  dynamic "egress" {
    for_each = each.value.egress-rules
    content {
      description      = egress.value["rule-description"]
      protocol         = lower(egress.value["rule-protocol"])
      from_port        = egress.value["rule-port-from"]
      to_port          = egress.value["rule-port-to"]
      cidr_blocks      = (egress.value["rule-source-ipv4"] != "" ? egress.value["rule-source-ipv4"] : null)
      ipv6_cidr_blocks = (egress.value["rule-source-ipv6"] != "" ? egress.value["rule-source-ipv6"] : null)
      prefix_list_ids  = (egress.value["rule-source-prefix-list"] != "" ? egress.value["rule-source-prefix-list"] : null)
      security_groups  = (egress.value["rule-source-security-group"] != "" ? egress.value["rule-source-security-group"] : null)
    }
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
