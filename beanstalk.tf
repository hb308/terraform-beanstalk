resource "aws_elastic_beanstalk_application" "my-test-beanstalk_application" {
  name = "my-test-beanstalk"
  description = "Beanstalk created from Terraform."
}

resource "aws_elastic_beanstalk_environment" "my-test-beanstalk_environment" {
  name = "my-test-beanstalk-environment"
  application = "${aws_elastic_beanstalk_application.my-test-beanstalk_application.name}"
  template_name = "${aws_elastic_beanstalk_configuration_template.my-test-beanstalk_configuration_template.name}"
}

resource "aws_elastic_beanstalk_configuration_template" "my-test-beanstalk_configuration_template" {
  name = "my-test-beanstalk-configuration_template"
  application = "${aws_elastic_beanstalk_application.my-test-beanstalk_application.name}"
  solution_stack_name = "64bit Amazon Linux 2017.03 v2.5.1 running Java 8"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "${aws_iam_instance_profile.instance_profile.arn}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "EnvironmentType"
    value = "SingleInstance"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "EC2KeyName"
    value = "beanstalkTests"
  }
}

resource "aws_s3_bucket_object" "my-test-beanstalk_bucket_object" {
  bucket = "beanstalk-spike-test"
  key    = "beanstalk/version-v2.zip"
  source = "version/version.zip"
}

resource "aws_elastic_beanstalk_application_version" "my-test-beanstalk_application_version" {
  name        = "my-test-beanstalk_application-v2"
  application = "${aws_elastic_beanstalk_application.my-test-beanstalk_application.name}"
  description = "Application version created by Terraform"
  bucket      = "beanstalk-spike-test"
  key         = "${aws_s3_bucket_object.my-test-beanstalk_bucket_object.id}"
}
