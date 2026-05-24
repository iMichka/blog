data "terraform_remote_state" "core" {
  backend = "s3"
  
  config = {
    bucket = "imichka-terraform-state"
    key    = "tfstate-s3-bucket"
    region = "eu-west-3"
  }
}
