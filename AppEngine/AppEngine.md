
# Deploying to Google App Engine using Terminal in Cloud Console

## Prerequisites

- A Google Cloud project
- App Engine enabled in your project
- Service account for app engine (grant role `storage.admin`)

## Steps to Deploy

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Open `Terminal` in `Google Console` and navigate to your project.
3. Create a file named `app.yaml` in your root project.
4. Configure your `app.yaml` based on your needs
   - Example of `app.yaml` using : [NodeJS](JS.app.yaml)
   - Example of `app.yaml` using : [Python](Python.app.yaml)
   - For simple deployment, you can use the following configuration:

     ```yaml
     runtime: python313
     # or 
     runtime: nodejs20
     ```

> [!Important]
>
> Make sure your app.yaml is in the root of your project.
> I suggest main application file should be named `main.py` or `index.js`
> and it should be in the root of your project.
>
> You do not need to manually install the modules (dependencies) before deployment in most cases. App Engine handles this for you during the deployment process.

5. Deploy your application

   ```bash
   gcloud app deploy
   ```

6. View your application

   ```bash
   gcloud app browse
   ```

## Additional Configuration

### Custom Domain

1. Configure domain in Cloud Console
2. Update DNS records
3. Verify domain ownership

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
