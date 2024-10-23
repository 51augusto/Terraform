provider "aws" {
  region  = "us-east-1"
  profile = "workload-prd"
  default_tags {
    tags = {
      IAC          = true
      Environment  = "prd"
      Application  = "Wordpress"
      map-migrated = "d-server-01oiau1h5afqhv"
    }
  }
}