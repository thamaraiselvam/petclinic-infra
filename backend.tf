terraform {

  backend "s3" {
    bucket = "terraform-petclinic"
    key    = "terraform"
    region = "ap-south-1"
  }
}

