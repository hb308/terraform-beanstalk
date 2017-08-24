terraform {
  required_version = ">= 0.9.9"

  backend "s3" {
    bucket = "beanstalk-spike-test"
    key = "test/terraform.state"
    region = "eu-west-2"
    profile = "beanstalk-spike"
  }
}