# Grafana API Key Rotation

We are unable to programatically rotate and consume the Grafana API key in Terraform, therefore we must rotate this externally.

To achieve this, we have created an [AWS Lambda function](https://github.com/ministryofjustice/modernisation-platform-environments/blob/8a569e5454739af170d6e8d7883bf03d6a65f258/terraform/environments/observability-platform/lambda-functions.tf#L1) to automatically recreate the key and upload it AWS Secrets Manager every 14 days.

Should this process fail, the following instructions can be used to  rotate it manually.

## Instructions

1. Log in to the Grafana instance via [AWS SSO](https://moj.awsapps.com/start#/).

1. Navigate to the "Home > Administration > API Keys" section.

1. Delete the expired API Key.

1. Generate a new API Key by clicking on the "Add API Key" button.

    - The key should be called `observability-platform-automation`

1. Copy the new API Key to your clipboard.

1. Login to the respective AWS environment, either `observability-platform-development` or `observability-platform-production`.

    - Open `AWS Secrets Manager`
    - Update `grafana/api-key` by selecting `Retrieve secret value`
    - Click `Edit`
    - Update the text with the new API Key.
    - Click `Save`

1. Save the changes.

Repeat these steps for both `dev` and `alpha` environments.
