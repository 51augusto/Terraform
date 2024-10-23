provider "aws" {
  alias   = "use1"
  region  = "us-east-1"
  profile = var.account_name
  default_tags {
    tags = merge(var.mandatory_tags, var.map_migration_tags)
  }
}

provider "aws" {
  alias   = "sae1"
  region  = "sa-east-1"
  profile = var.account_name
  default_tags {
    tags = merge(var.mandatory_tags, var.map_migration_tags)
  }
}