# Grafana API Key Rotation 🔑♻️

This runbook provides instructions on how to rotate an API Key in Grafana. This need to be done every 30 days. If it is not done you will see errors such as this:

```bash
│ Error: the Grafana client is required for `grafana_data_source`. Set the auth and url provider attributes
│
│   with module.cloudwatch_sources["data-platform-preproduction"].grafana_data_source.this,
│   on modules/grafana/cloudwatch-source/main.tf line 5, in resource "grafana_data_source" "this":
│    5: resource "grafana_data_source" "this" {
│
╵
```

## Instructions

Follow these steps to rotate an API Key:

1. Log in to the Grafana instance via [AWS SSO](https://moj.awsapps.com/start#/).

1. Navigate to the "Home > Administration > API Keys" section.

1. Delete the expired API Key.

1. Generate a new API Key by clicking on the "Add API Key" button.

    - The key should be called `terraform`

1. Copy the new API Key to your clipboard.

1. Login to the respective AWS environment, either `observability-platform-development` or `observability-platform-production`.

    - Open `AWS Secrets Manager`
    - Update `grafana/api-key` by selecting `Retrieve secret value`
    - Click `Edit`
    - Update the text with the new API Key.
    - Click `Save`

1. Save the changes.

Repeat these steps for both `dev` and `alpha` environments.

## Automation

An [issue](https://github.com/ministryofjustice/observability-platform/issues/18) has been created to automate this process.
