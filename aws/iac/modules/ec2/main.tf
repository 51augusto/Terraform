resource "aws_instance" "instance" {
  ami                                  = var.ami
  instance_type                        = var.instance_type
  key_name                             = local.key
  user_data                            = replace(local.final_user_data, "\r\n", "\n")
  source_dest_check                    = var.source_dest_check
  subnet_id                            = var.subnet
  private_ip                           = var.private_ip
  vpc_security_group_ids               = var.security_group_ids == null ? [aws_security_group.sg.id] : concat([aws_security_group.sg.id], var.security_group_ids)
  associate_public_ip_address          = var.public_ip
  iam_instance_profile                 = aws_iam_instance_profile.profile.name
  ebs_optimized                        = var.ebs_optimized
  monitoring                           = var.monitoring
  disable_api_termination              = var.termination_protection
  instance_initiated_shutdown_behavior = "stop"
  user_data_replace_on_change          = false

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = var.enable_metadata_tags ? "enabled" : "disabled"
  }

  root_block_device {
    volume_size           = var.root_ebs.size
    volume_type           = var.root_ebs.type
    encrypted             = var.root_ebs.encrypted
    delete_on_termination = var.root_ebs.delete_on_termination
    tags = merge({
      Name = local.ebs_name
    }, data.aws_default_tags.default_tags.tags)
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags["StartStopScheduled"]
    ]
  }
}

resource "aws_eip" "eip" {
  count    = var.public_ip ? 1 : 0
  instance = aws_instance.instance.id
  domain   = "vpc"
  tags = {
    Name = local.eip_name
  }
}