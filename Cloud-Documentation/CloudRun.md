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
   - Example of `Dockerfile` using `NodeJS` :

     ```docker
      # Use an official Node.js image as the base
      FROM node:18

      # Set the working directory to /app
      WORKDIR /app

      # Copy the package*.json files to the working directory
      COPY package*.json ./

      # Install the dependencies
      RUN npm install

      # Copy the application code to the working directory
      COPY . .

      # Set the environment variables
      ENV port=8080

      # Expose the port the application will run on
      EXPOSE 8080

      # Run the command to start the server in production mode
      CMD ["node", "src/server/server.js"]
     ```

   - Example of `Dockerfile` using `Python` :

     ```docker
      # Use an official Python image as the base
      FROM python:3.13

      # Set the working directory to /app
      WORKDIR /app

      # Copy the requirements.txt file to the working directory
      COPY requirements.txt ./ 

      # Install the dependencies
      RUN pip install --no-cache-dir -r requirements.txt

      # Copy the application code to the working directory
      COPY . .

      # Set environment variables (optional)
      ENV PORT=8080

      # Expose the port the application will run on
      EXPOSE 8080

      # If using Flask, use this command instead
      ENV FLASK_APP=main.py
      CMD ["flask", "run", "--host", "0.0.0.0"]

      # If using uvicorn, use this command instead
      CMD ["uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8080"]

      # Run the command to start the server (adjust to your app's entry point)
      CMD ["python", "src/server/server.py"]

     ```

5. Create a .dockerignore and configure it to exclude unnecessary files.
6. Build your Docker image :

   ```bash
    docker build -t PATH/TO/YOUR/IMAGE:TAGS .
    # Example
    # docker build -t us-central1-docker.pkg.dev/testing/test-image/image:v1 .
   ```

7. Push your image to Artifact Registry :

   ```bash
    docker push PATH/TO/YOUR/IMAGE:TAGS
    # Example
    # docker push us-central1-docker.pkg.dev/testing/test-image/image:v1
   ```

8. Deploy to Cloud Run

   ```bash
    gcloud run deploy YOUR-SERVICE-NAME \
      --image PATH/TO/YOUR/IMAGE:TAGS \
      --service-account SERVICE_ACCOUNT_NAME@PROJECT_ID.iam.gserviceaccount.com \
      --set-env-vars KEY_1=VALUE_1,
          KEY_2=VALUE_2,
          KEY_3=VALUE_3 \
      --platform managed \
      --region YOUR-REGION \
      --allow-unauthenticated
    # Example
    # gcloud run deploy ml-backend-api \
    #   --image us-central1-docker.pkg.dev/testing/test-image/image:v1 \
    #   --service-account test-admin@testing.iam.gserviceaccount.com \
    #   --set-env-vars MODEL_URL=https://storage.googleapis.com/model/model.json,
    #       PROJECT_ID=testing,
    #       FIRESTORE_COLLECTION=test-collection \
    #   --platform managed \
    #   --region us-central1 \
    #   --allow-unauthenticated
   ```

> [!Important]
>
> - `--platform managed`: Uses fully managed Cloud Run
> - `--region`: Specifies deployment region
> - `--allow-unauthenticated`: Makes service publicly accessible
> - `--memory`: Set memory limit (e.g., --memory 512Mi)
> - `--cpu`: Set CPU allocation (e.g., --cpu 1)
> - `--port`: Specify container port (default: 8080)
> - `--max-instances`: Set maximum number of instances (default: 1)
> - `--min-instances`: Set minimum number of instances
> - `--timeout`: Set request timeout (e.g., --timeout 10s)
> - `--concurrency`: Set concurrency level (default: 80)
>
> ##### Optional parameters
>
> - `--set-env-vars`: Set environment variables
> - `--service-account`: The service account to use for the service.

## Monitoring Deployment

```bash
gcloud run services describe YOUR-SERVICE-NAME
```

## Clean Up

To delete the service:

```bash
gcloud run services delete YOUR-SERVICE-NAME
```
