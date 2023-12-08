# Architecture

Observability Platform is comprised of Amazon Managed Grafana (AMG) and Amazon Managed Prometheus (AMP).

The current core offering is to provide one central UI (AMG) for visualising multiple AWS account's CloudWatch Logs and Metrics.

Additionally the platform offers a central metric store (AMP), allowing tenants to remote write data for consumption in the same central UI (AMG).

![Observability Platform](./src/architecture/architecture.svg)


## Environments

The current implementation has two environments:

- `development`

- `alpha`

All non-production workloads (e.g. `development`, `test`, `staging`, `nonproduction`) will publish to `development`,
while production workloads (e.g `production`) will publish to `production`.


## Deployment

Observability Platform is deployed to [Modernisation Platform](https://user-guide.modernisation-platform.service.justice.gov.uk/), our source is available [here](https://github.com/ministryofjustice/modernisation-platform-environments/tree/main/terraform/environments/observability-platform).
