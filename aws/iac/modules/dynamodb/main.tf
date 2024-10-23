resource "aws_dynamodb_table" "table" {
  name           = local.name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  table_class    = var.table_class

  hash_key  = var.hash_key.name
  range_key = var.range_key != null ? var.range_key.name : null

  dynamic "attribute" {
    for_each = local.attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  dynamic "ttl" {
    for_each = var.ttl.enabled ? [1] : []
    content {
      enabled        = var.ttl.enabled
      attribute_name = var.ttl.attribute
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_indexes
    iterator = index
    content {
      name               = index.value["name"]
      range_key          = index.value["range_key"]
      projection_type    = index.value["projection_type"]
      non_key_attributes = index.value["non_key_attributes"]
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_indexes
    iterator = index
    content {
      name               = index.value["name"]
      read_capacity      = index.value["read_capacity"]
      write_capacity     = index.value["write_capacity"]
      hash_key           = index.value["hash_key"]
      range_key          = index.value["range_key"]
      projection_type    = index.value["projection_type"]
      non_key_attributes = index.value["non_key_attributes"]
    }
  }

  tags = local.tags
}