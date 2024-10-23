module "asg_use1" {
  source         = "./auto-scaling-group/"
  providers      = { aws = aws.use1 }
  name           = "jmeter"
  component_name = "internal"
  region         = "us-east-1"
  environment    = var.environment
  ami            = "ami-03ededff12e34e59e"
  instance_type  = "t3.large"
  key_name       = "ec2-key-${module.this_use1.custom_context_id}-linux"
  policy_arns    = [aws_iam_policy.jmeter_get_pkg.arn]
  user_data      = file("${path.module}/user_data.sh")
  scaling_size   = "0"
  subnet         = data.terraform_remote_state.remote.outputs.vpc_use1_private_subnets_ids[0]
}

module "asg_sae1" {
  source         = "./auto-scaling-group/"
  providers      = { aws = aws.sae1 }
  name           = "jmeter"
  component_name = "internal"
  region         = "sa-east-1"
  environment    = var.environment
  ami            = "ami-00d10ca79f70a302a"
  instance_type  = "t3.large"
  key_name       = "ec2-key-${module.this_sae1.custom_context_id}-linux"
  policy_arns    = [aws_iam_policy.jmeter_get_pkg.arn]
  user_data      = file("${path.module}/user_data.sh")
  scaling_size   = "0"
  subnet         = data.terraform_remote_state.remote.outputs.vpc_sae1_private_subnets_ids[0]
}


module "jmeter_server_use1" {
  source                 = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/ec2.git?ref=main"
  providers              = { aws = aws.use1 }
  ami                    = "ami-03b21d9626fa13382"
  name                   = "jmeter-server"
  component_name         = "internal"
  region                 = "us-east-1"
  instance_type          = "t3.large"
  os                     = "windows"
  hostname               = "jmeter-server-use1"
  termination_protection = true
  availability_time      = "poweroff"
  environment            = var.environment
  policy_arns            = [aws_iam_policy.jmeter_describe_instance.arn]
  subnet                 = data.terraform_remote_state.remote.outputs.vpc_use1_private_subnets_ids[0]
  security_group_ids     = [module.asg_use1.rmi_port_sg]
  tags = {
    Role    = "jmeter-server"
    OS      = "windows"
    Version = "Windows Server 2022"
  }
}

module "jmeter_server_sae1" {
  source                 = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/ec2.git?ref=main"
  providers              = { aws = aws.sae1 }
  ami                    = "ami-07a8ebcde73348126"
  name                   = "jmeter-server"
  component_name         = "internal"
  region                 = "sa-east-1"
  instance_type          = "t3.large"
  os                     = "windows"
  hostname               = "jmeter-server-sae1"
  termination_protection = true
  availability_time      = "poweroff"
  environment            = var.environment
  policy_arns            = [aws_iam_policy.jmeter_describe_instance.arn]
  subnet                 = data.terraform_remote_state.remote.outputs.vpc_sae1_private_subnets_ids[0]
  security_group_ids     = [module.asg_sae1.rmi_port_sg]
  tags = {
    Role    = "jmeter-server"
    OS      = "windows"
    Version = "Windows Server 2022"
  }
}