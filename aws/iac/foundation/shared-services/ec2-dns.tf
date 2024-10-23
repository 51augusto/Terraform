locals {
  dns_instance_name   = "ec2-${module.this_sae1.custom_context_id}-dns"
  dns_sg_name         = "SG-ec2-${module.this_sae1.custom_context_id}-dns"
  dns_role_name       = "role-ec2-${module.this_sae1.custom_context_id}-dns"
  dns_profile_name    = "profile-ec2-${module.this_sae1.custom_context_id}-dns"
  dns_ebs_name        = "ebs-ec2-${module.this_sae1.custom_context_id}-dns"
  dns_ebs_volume_name = "ebs-ec2-${module.this_sae1.custom_context_id}-dns-volume"
}

resource "aws_iam_role" "dns_role" {
  provider    = aws.sae1
  name        = local.dns_role_name
  description = "Role da instancia EC2 ${local.dns_instance_name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::788006387775:policy/policy-s3-internal-shared-sae1-ssm-resources"
  ]
  tags = {
    Name = local.dns_role_name
  }
}

resource "aws_iam_instance_profile" "dns_profile" {
  provider = aws.sae1
  name     = local.dns_profile_name
  role     = aws_iam_role.dns_role.name
  tags = {
    Name = local.dns_profile_name
  }
}


resource "aws_instance" "dns_sae1" {
  provider                = aws.sae1
  ami                     = "ami-02d8baf2eb92d1e9e"
  iam_instance_profile    = aws_iam_instance_profile.dns_profile.id
  vpc_security_group_ids  = [aws_security_group.ec2_dns_sae1.id]
  instance_type           = "t3.medium"
  subnet_id               = module.vpc_sae1.intra_subnets[0]
  key_name                = "ec2-key-internal-shared-sae1-windows"
  disable_api_termination = true

  root_block_device {
    encrypted   = true
    volume_size = "80"
    tags = merge(var.tags, {
      Name = local.dns_ebs_name
    })
  }

  tags = {
    Name               = local.dns_instance_name
    OS                 = "windows"
    Role               = "AD DNS"
    Version            = "Windows Server 2019"
    Backup             = "true"
    PrometheusExporter = "true"
  }
}

resource "aws_ebs_volume" "dns_sysvol_sae1" {
  provider          = aws.sae1
  availability_zone = module.vpc_sae1.azs[0]
  encrypted         = true
  size              = 60

  tags = {
    Name = local.dns_ebs_volume_name
  }
}

resource "aws_volume_attachment" "dns_sysvol_sae1" {
  provider    = aws.sae1
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.dns_sysvol_sae1.id
  instance_id = aws_instance.dns_sae1.id
}

resource "aws_security_group" "ec2_dns_sae1" {
  provider    = aws.sae1
  name        = local.dns_sg_name
  description = "EC2 Windows de DNS"
  vpc_id      = module.vpc_sae1.vpc_id

  egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "DNS"
    from_port   = 53
    to_port     = 53
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = ""
    from_port   = 42
    to_port     = 42
    protocol    = "UDP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = "DNS"
    from_port   = 53
    to_port     = 53
    protocol    = "UDP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = ""
    from_port   = 135
    to_port     = 445
    protocol    = "UDP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = ""
    from_port   = 88
    to_port     = 88
    protocol    = "UDP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = ""
    from_port   = 42
    to_port     = 42
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = ""
    from_port   = 88
    to_port     = 88
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = ""
    from_port   = 135
    to_port     = 445
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = ""
    from_port   = 1024
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = ""
    from_port   = 0
    to_port     = 65535
    protocol    = "UDP"
    cidr_blocks = ["10.199.40.46/32"]
  }

  ingress {
    description = ""
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["10.150.200.20/32"]
  }

  ingress {
    description = "Tenable - Nessus"
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["10.199.40.46/32"]
  }

  ingress {
    description = ""
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["10.199.40.46/32"]
  }

  tags = {
    Name = local.dns_sg_name
  }
}
