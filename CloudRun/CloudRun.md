# Deploying to Cloud Run using Docker

## Prerequisites

- A Google Cloud project with billing enabled
- Artifact Registry API enabled
- Cloud Run API enabled
- Service account with `Artifact Registry Writer` role
  (If you want an instant way, just grant a `Editor` or `Owner` role)

## Steps

1. Open `Artifact Registry` and create a repository with format `Docker`.
2. Remember your repository name and its location.
3. Open `Terminal` in `Google Console` and naviage to your project.
4. Create a `Dockerfile` in your root project if you don't have one.
   - Example of `Dockerfile` using `NodeJS` : [Dockerfile](JS.Dockerfile)
   - Example of `Dockerfile` using `Python` : [Dockerfile](Python.Dockerfile)

5. Create a `.dockerignore` and configure it to exclude unnecessary files.
6. Example command : [Cloud Run Deployment](script.sh)
7. Build your Docker image :

   ```bash
    docker build -t PATH/TO/YOUR/IMAGE:TAGS .
   ```

8. Push your image to Artifact Registry :

   ```bash
    docker push PATH/TO/YOUR/IMAGE:TAGS
   ```

9. Deploy to Cloud Run :

   ```bash
    gcloud run deploy YOUR-SERVICE-NAME \
      --image PATH/TO/YOUR/IMAGE:TAGS \
      --service-account SERVICE_ACCOUNT_NAME@PROJECT_ID.iam.gserviceaccount.com \
      --set-env-vars KEY_1=VALUE_1,KEY_2=VALUE_2,KEY_3=VALUE_3 \
      --platform managed \
      --region YOUR-REGION \
      --allow-unauthenticated
   ```

> [!Important]
>
> - `--set-env-vars`: Set environment variables
> - `--service-account`: The service account to use for the service.
> - `--platform managed`: Uses fully managed Cloud Run
> - `--region`: Specifies deployment region
> - `--allow-unauthenticated`: Makes service publicly accessible
> - `--memory`: Set memory limit (e.g., --memory 512Mi)
> - `--cpu`: Set CPU allocation (e.g., --cpu 1)
> - `--port`: Specify container port (default: 8080)
> - `--max-instances`: Set maximum number of instances (default: 1)
> - `--min-instances`: Set minimum number of instances
> - `--timeout`: Set request timeout (e.g., --timeout 10s)
> - `--concurrency`: Sets the maximum number of requests that a single instance can handle simultaneously (default: 80)

## Monitoring Deployment

```bash
gcloud run services describe YOUR-SERVICE-NAME
```

## Clean Up

To delete the service:

```bash
gcloud run services delete YOUR-SERVICE-NAME
```