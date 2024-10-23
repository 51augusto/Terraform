resource "aws_apigatewayv2_authorizer" "authorizer" {
  name                             = local.authorizer_name
  api_id                           = var.api_id
  authorizer_type                  = "JWT"
  identity_sources                 = ["$request.header.Authorization"]
  authorizer_result_ttl_in_seconds = 0

  jwt_configuration {
    audience = [for c in aws_cognito_user_pool_client.user_pool_client : c.id]
    issuer   = "https://${aws_cognito_user_pool.user_pool.endpoint}"
  }
}

resource "aws_cognito_user_pool" "user_pool" {
  name                = local.user_pool_name
  deletion_protection = var.deletion_protection ? "ACTIVE" : "INACTIVE"

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  tags = {
    Name = local.user_pool_name
  }
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain          = var.endpoint_domain
  user_pool_id    = aws_cognito_user_pool.user_pool.id
  certificate_arn = var.endpoint_certificate_arn
}

resource "aws_cognito_resource_server" "default_resource" {
  identifier   = "default"
  name         = "default"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  scope {
    scope_name        = "default"
    scope_description = "Escopo padrão da API"
  }
}

resource "aws_cognito_resource_server" "resource" {
  for_each     = var.resources
  identifier   = each.key
  name         = each.key
  user_pool_id = aws_cognito_user_pool.user_pool.id

  dynamic "scope" {
    for_each = each.value
    content {
      scope_name        = scope.key
      scope_description = scope.value
    }
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  for_each                             = var.clients
  name                                 = each.key
  user_pool_id                         = aws_cognito_user_pool.user_pool.id
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  generate_secret                      = true
  allowed_oauth_scopes = concat(
    aws_cognito_resource_server.default_resource.scope_identifiers,
    each.value != null ? each.value : []
  )
  depends_on = [aws_cognito_resource_server.resource]
}