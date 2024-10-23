output "file_system" {
  value       = aws_efs_file_system.file_system
  description = "File system do EFS."
}

output "access_points" {
  value       = aws_efs_access_point.access_points
  description = "Access Points do EFS"
}

output "security_group" {
  value       = aws_security_group.sg
  description = "Security Group do EFS"
}