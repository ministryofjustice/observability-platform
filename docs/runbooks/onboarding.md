# Onboarding

> This is alpha documentation and subject to change without notice

1. Tenant creates Observability Platform resources in their account

    ```hcl
    module "observability_platform_tenant" {
      source  = "ministryofjustice/observability-platform-tenant/aws"
      version = "<see https://registry.terraform.io/modules/ministryofjustice/observability-platform-tenant/aws/latest for latest>"

      observability_platform_account_id = local.environment_management.account_ids["observability-platform-${ENVIRONMENT}"]
    }
    ```

1. Tenant provides the following information to Observability Platform

    - Tenant name (e.g. Data Platform)

    - GitHub team name (used for access control)

      - Note: If the team is a parent of other teams, child team's members will be included as part of the parent team's members,
        this is a quirk of <https://github.com/ministryofjustice/moj-terraform-scim-github>

    - Account names

1. Observabilty Platform creates tenant configuration in Modernisation Platform ([`observability-platform/environment-configurations.tf`](https://github.com/ministryofjustice/modernisation-platform-environments/blob/main/terraform/environments/observability-platform/environment-configurations.tf))

    ```hcl
    tenant_configuration = {
      "tenant-name" = {
        identity_centre_team = "<Retrieve this from AWS Identity Center>"
        aws_accounts = {
          "observability-platform-production" = {
            cloudwatch_enabled      = true
            prometheus_push_enabled = true
            xray_enabled            = true
          }
        }
      }
    }
    ```
