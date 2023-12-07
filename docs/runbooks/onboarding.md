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

    - Team name (e.g. Data Platform)

    - GitHub team name (used for access control)

    - Account names

1. Observabilty Platform creates tenant configuration in Modernisation Platform ([`observability-platform/environment-configurations.tf`](https://github.com/ministryofjustice/modernisation-platform-environments/blob/main/terraform/environments/observability-platform/environment-configurations.tf))

    ```hcl
    observability_platform_configuration = {
      "team-name" = {
        sso_uuid = "<Retrieve this from AWS Identity Center>"
          cloudwatch_accounts = [
            "account-name-x",
            "account-name-y",
            "account-name-z"
          ]
      }
    }
    ```
