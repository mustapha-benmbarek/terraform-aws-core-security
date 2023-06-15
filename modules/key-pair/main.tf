resource "aws_key_pair" "this" {
  for_each   = var.core-key-pairs
  key_name   = each.value.name
  public_key = each.value.public-key
  tags = {
    Name = each.key
  }
}
