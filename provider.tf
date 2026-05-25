provider "aws" {
  region = var.region
}

# Required for dynamic S3 name
provider "random" {}
