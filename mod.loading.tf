/*Data loading...*/
locals {
  data-key-pairs   = try(jsondecode(file(var.file-key-pairs)), [])
  data-nework-acls = try(jsondecode(file(var.file-nework-acls)), [])
  //data-security-groups = try(jsondecode(file(var.file-security-groups)), [])
}

/*Data decoding...*/
locals {
  lst-key-pairs   = try({ for obj in local.data-key-pairs.key-pairs : obj.name => obj }, tomap({}))
  lst-nework-acls = try({ for obj in local.data-nework-acls.nework-acls : obj.name => obj }, tomap({}))
  //lst-security-groups = try({ for obj in local.data-security-groups.security-groups : obj.name => obj }, tomap({}))
}
