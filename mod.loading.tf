/*Data loading...*/
locals {
  data-key-pairs    = try(jsondecode(file(var.file-key-pairs)), [])
  data-network-acls = try(jsondecode(file(var.file-network-acls)), [])
  //data-security-groups = try(jsondecode(file(var.file-security-groups)), [])
  data-acm-public-certificates = try(jsondecode(file(var.file-acm-public-certificates)), [])
}

/*Data decoding...*/
locals {
  lst-key-pairs    = try({ for obj in local.data-key-pairs.key-pairs : obj.name => obj }, tomap({}))
  lst-network-acls = try({ for obj in local.data-network-acls.network-acls : obj.name => obj }, tomap({}))
  //lst-security-groups = try({ for obj in local.data-security-groups.security-groups : obj.name => obj }, tomap({}))
  lst-acm-public-certificates = try({ for obj in local.data-acm-public-certificates.public-certificates : obj.name => obj }, tomap({}))
}
