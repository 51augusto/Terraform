resource "aws_resourcegroups_group" "use1" {
  name     = module.this_use1["shared"].rg_id
  provider = aws.use1

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = [
        "AWS::AllSupported"
      ],
      TagFilters = [
        {
          Key = "Environment"
        },
        {
          Key = "IAC"
        },
        {
          Key = "Name"
        }
      ]
    })
  }

  tags = module.this_use1["shared"].rg_tags
}

resource "aws_resourcegroups_group" "sae1" {
  name     = module.this_sae1["shared"].rg_id
  provider = aws.sae1

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = [
        "AWS::AllSupported"
      ],
      TagFilters = [
        {
          Key = "Environment"
        },
        {
          Key = "IAC"
        },
        {
          Key = "Name"
        }
      ]
    })
  }

  tags = module.this_sae1["shared"].rg_tags
}