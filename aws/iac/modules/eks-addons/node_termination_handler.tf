resource "helm_release" "aws_node_termination_handler" {
  count      = var.install_node_termination_handler ? 1 : 0
  name       = "aws-node-termination-handler"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts/"
  chart      = "aws-node-termination-handler"
  version    = "0.21.0"
  values     = [replace(file("${path.module}/helm_values/aws_node_termination_handler.yaml"), "\r\n", "\n")]

  set {
    name  = "webhookURL"
    value = var.node_termination_slack_webhook
  }
}