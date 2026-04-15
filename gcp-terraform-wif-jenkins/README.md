```md
# GCP Terraform with WIF + Jenkins

## 🚀 Features
- No service account keys
- Workload Identity Federation
- Jenkins CI/CD pipeline
- Remote Terraform state (GCS)

## 🛠️ Setup Steps

Open the Cloud Shell
```
gcloud project list
```

Select the required project 
gcloud set project <project ID>
```

### 1. Create GCS bucket
```
gsutil mb -p <PROJECT_ID> gs://my-terraform-state-bucket
```

### 2. Enable APIs
```
gcloud services enable iam.googleapis.com compute.googleapis.com
```

gcloud iam list

gcloud iam service-accounts list

### 3. Create Service Account
```
gcloud iam service-accounts create jenkins-sa
```
gcloud-iam service-accounts create jenkins-sa --display-name="Jenkins Service Account"

### 4. Grant Roles
```
gcloud projects add-iam-policy-binding <PROJECT_ID> \
  --member="serviceAccount:jenkins-sa@<PROJECT_ID>.iam.gserviceaccount.com" \
  --role="roles/compute.admin"
```
### Example:
```gcloud projects add-iam-policy-binding mystic-centaur-297207   --member="serviceAccount:jenkins-sa@mystic-centaur-297207.iam.gserviceaccount.com"   --role="roles/storage.admin"```

### To add couple of roles at a same time
```for role in roles/storage.admin roles/compute.admin roles/run.admin roles/iam.serviceAccountUser
do
  gcloud projects add-iam-policy-binding mystic-centaur-297207 \
    --member="serviceAccount:jenkins-sa@mystic-centaur-297207.iam.gserviceaccount.com" \
    --role="$role"
done
```

### 5. Configure Workload Identity Federation
- Create pool
- Create provider
- Bind SA with roles/iam.workloadIdentityUser

### 6. Run Jenkins Pipeline
- Configure OIDC in Jenkins
- Run pipeline

## ⚠️ Notes
- Do NOT use service account keys
- Restrict firewall in production
- Use least privilege IAM roles
```
