#!/bin/bash

# Build and deploy the Cloud Run service
echo "================================================================================="
echo "Example of Cloud Run deployment with :"
echo -e "\tregion : us-central1"
echo -e "\trepo name : testing"
echo -e "\timage name : test-image/image"
echo -e "\ttags : v1"
echo -e "\tservice account : test-admin@testing.iam.gserviceaccount.com"
echo "================================================================================="

echo -e "\nMake sure that you have configured the command before running this script.\n"
echo -n "Are you sure you want to continue? (y/n) : "
read confirmation

if [ "$confirmation" != "y" ] || [ "$confirmation" != "Y" ]; then
    echo "Deployment cancelled."
    exit 1
fi

# Configure with your own project
echo "Building Docker image..."
docker build -t us-central1-docker.pkg.dev/testing/test-image/image:v1 .

echo "Pushing Docker image to Artifact Registry..."
docker push us-central1-docker.pkg.dev/testing/test-image/image:v1

echo "Deploying Cloud Run service..."
gcloud run deploy ml-backend-api \
  --image us-central1-docker.pkg.dev/testing/test-image/image:v1 \
  --service-account test-admin@testing.iam.gserviceaccount.com \
  --set-env-vars MODEL_URL=https://storage.googleapis.com/model/model.json,
      PROJECT_ID=testing,
      FIRESTORE_COLLECTION=test-collection \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated