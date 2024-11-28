
# Deploying to Google App Engine using CLI

## Prerequisites

- Google Cloud SDK installed
- A Google Cloud project
- App Engine enabled in your project

## Steps to Deploy

1. Initialize your project

gcloud init


2. Configure your app.yaml

runtime: python39  # Or your preferred runtime
instance_class: F1  # Choose instance class
automatic_scaling:
  target_cpu_utilization: 0.65
  min_instances: 1
  max_instances: 10


3. Deploy your application

gcloud app deploy


4. View your application

gcloud app browse


## Additional Configuration

### Environment Variables
Add environment variables in app.yaml:

env_variables:
  VARIABLE_NAME: "value"


### Custom Domain
1. Configure domain in Cloud Console
2. Update DNS records
3. Verify domain ownership

### Scaling Configuration

automatic_scaling:
  min_instances: 1
  max_instances: 10
  target_cpu_utilization: 0.65
  target_throughput_utilization: 0.65
  max_concurrent_requests: 50


### Network Settings

network:
  instance_tag: my-app
  name: default


## Monitoring
- View logs: `gcloud app logs tail`
- Monitor in Cloud Console
- Set up alerts and metrics

## Common Issues
1. Deployment timeout
   - Check instance configuration
   - Verify network settings

2. Memory issues
   - Adjust instance class
   - Optimize application code

3. Cold starts
   - Configure min_instances
   - Use warmup requests
