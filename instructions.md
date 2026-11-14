$PROJECT_ID = gcloud config get-value project
$PROJECT_NUMBER = gcloud projects describe $PROJECT_ID --format="value(projectNumber)"
$GITHUB_USER = "Thrinath002"
$REPO = "gitops-demo"
$SA = "terraform-sa@$PROJECT_ID.iam.gserviceaccount.com"

gcloud storage buckets create "gs://$PROJECT_ID-tfstate" --location=asia-south1 --uniform-bucket-level-access
gcloud storage buckets update "gs://$PROJECT_ID-tfstate" --versioning

gcloud services enable serviceusage.googleapis.com cloudresourcemanager.googleapis.com iam.googleapis.com iamcredentials.googleapis.com sts.googleapis.com

gcloud iam service-accounts create terraform-sa --display-name="Terraform GitHub Actions"

foreach ($role in "roles/editor","roles/container.admin","roles/resourcemanager.projectIamAdmin","roles/iam.serviceAccountAdmin") {
  gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$SA" --role=$role --condition=None
}

gcloud iam workload-identity-pools create github-pool --location=global --display-name="GitHub Pool"

gcloud iam workload-identity-pools providers create-oidc github-provider --location=global --workload-identity-pool=github-pool --issuer-uri="https://token.actions.githubusercontent.com" --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository" --attribute-condition="assertion.repository=='$GITHUB_USER/$REPO'"

gcloud iam service-accounts add-iam-policy-binding $SA --role="roles/iam.workloadIdentityUser" --member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/github-pool/attribute.repository/$GITHUB_USER/$REPO"