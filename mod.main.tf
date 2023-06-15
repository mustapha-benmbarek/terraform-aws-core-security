/*Security Module | EC2 Key Pair*/
module "key-pairs" {
  source         = "./modules/key-pair"
  core-key-pairs = local.lst-key-pairs
}

/*Security Module | Network Access Control List (ACL)*/
module "network-acls" {
  source            = "./modules/network-acl"
  core-vpcs         = module.vpcs.ids
  core-vpc-subnets  = module.vpc-subnets.ids
  core-network-acls = local.lst-network-acls

}

/*Security Module | Security Group*/
module "security-groups" {
  source               = "./modules/security-group"
  core-vpcs            = module.vpcs.ids
  core-security-groups = local.lst-security-groups
}