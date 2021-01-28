terraform {
  backend "s3" {
    bucket = "tf-state-petclinic"
    key    = "terraform"
    region = "ap-south-1"
  }
}

