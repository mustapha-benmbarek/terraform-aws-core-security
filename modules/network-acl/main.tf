resource "aws_network_acl" "this" {
  for_each   = var.core-network-acls
  vpc_id     = var.core-vpcs[each.value.vpc-name].id
  subnet_ids = [for s in each.value.subnets : var.core-vpc-subnets[s].id]


  dynamic "ingress" {
    for_each = each.value.ingress-rules
    content {
      rule_no         = ingress.value["rule-number"]
      action          = ingress.value["rule-action"]
      protocol        = lower(ingress.value["rule-protocol"])
      cidr_block      = ingress.value["rule-source-ipv4"] != "" ? ingress.value["rule-source-ipv4"] : null
      ipv6_cidr_block = ingress.value["rule-source-ipv6"] != "" ? ingress.value["rule-source-ipv6"] : null
      from_port       = ingress.value["rule-port-from"]
      to_port         = ingress.value["rule-port-to"]
    }
  }

  dynamic "egress" {
    for_each = each.value.egress-rules
    content {
      rule_no         = egress.value["rule-number"]
      action          = egress.value["rule-action"]
      protocol        = lower(egress.value["rule-protocol"])
      cidr_block      = egress.value["rule-destination-ipv4"] != "" ? egress.value["rule-destination-ipv4"] : null
      ipv6_cidr_block = egress.value["rule-destination-ipv6"] != "" ? egress.value["rule-destination-ipv6"] : null
      from_port       = egress.value["rule-port-from"]
      to_port         = egress.value["rule-port-to"]
    }
  }

  tags = {
    Name = each.key
  }
}
