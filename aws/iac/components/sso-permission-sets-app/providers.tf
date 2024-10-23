provider "aws" {
  region  = "us-east-1"
  profile = "management"

  default_tags {
    tags = {
      Environment  = "root"
      IAC          = true
      map-migrated = "d-server-01oiau1h5afqhv"
    }
  }
}