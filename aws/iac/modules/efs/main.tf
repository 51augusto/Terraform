resource "aws_efs_file_system" "file_system" {
  creation_token                  = local.efs_fs_name
  encrypted                       = var.encrypted
  performance_mode                = var.performance_mode
  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput

  dynamic "lifecycle_policy" {
    for_each = var.transition_to_ia != null ? [1] : []
    content {
      transition_to_ia = var.transition_to_ia
    }
  }

  dynamic "lifecycle_policy" {
    for_each = var.transition_to_primary_storage_class != null ? [1] : []
    content {
      transition_to_primary_storage_class = var.transition_to_primary_storage_class
    }
  }

  tags = {
    Name   = local.efs_fs_name
    Backup = var.dr_backup
  }
}

resource "aws_efs_mount_target" "mount_target" {
  for_each        = toset(var.subnets_ids)
  file_system_id  = aws_efs_file_system.file_system.id
  subnet_id       = each.key
  security_groups = [aws_security_group.sg.id]
}

resource "aws_efs_access_point" "access_points" {
  for_each       = var.access_points
  file_system_id = aws_efs_file_system.file_system.id

  posix_user {
    uid = each.value["uid"]
    gid = each.value["gid"]
  }

  root_directory {
    path = each.value["path"]
    creation_info {
      owner_uid   = each.value["uid"]
      owner_gid   = each.value["gid"]
      permissions = each.value["permissions"]
    }
  }

  tags = {
    Name = "${local.efs_ap_base_name}-${each.key}"
  }
}