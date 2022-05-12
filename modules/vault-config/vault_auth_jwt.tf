resource "vault_jwt_auth_backend" "jwt" {
  type               = "jwt"
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  tune {
    default_lease_ttl            = "168h"
    max_lease_ttl                = "720h"
    token_type                   = "default-service"
    passthrough_request_headers  = []
    allowed_response_headers     = []
    audit_non_hmac_request_keys  = []
    audit_non_hmac_response_keys = []
  }
}

resource "vault_jwt_auth_backend_role" "github-action" {
  backend         = vault_jwt_auth_backend.jwt.path
  role_type       = "jwt"
  role_name       = "github-action"
  user_claim      = "sub"
  groups_claim    = "environment"
  bound_audiences = ["https://github.com/jtcressy", "https://github.com/jtcressy-home"]
  claim_mappings = {
    "actor"            = "actor"
    "job_workflow_ref" = "job_workflow_ref"
    "run_id"           = "run_id"
    "run_attempt"      = "run_attempt"
    "run_number"       = "run_number"
    "sub"              = "sub"
  }
  token_policies = ["default"]
}
