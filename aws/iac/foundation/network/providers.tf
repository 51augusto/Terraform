provider "aws" {
  alias   = "use1"
  region  = "us-east-1"
  profile = "network"
  default_tags {
    tags = var.tags
  }
}

provider "aws" {
  alias   = "sae1"
  region  = "sa-east-1"
  profile = "network"
  default_tags {
    tags = var.tags
  }
}