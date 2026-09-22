import {
  to = google_compute_global_address.todo_ip
  id = "projects/project-f0ad4dfa-b194-4dc6-963/global/addresses/todo-ip"
}

resource "google_compute_global_address" "todo_ip" {
  name = "todo-ip"
}

import {
  to = google_artifact_registry_repository.kubecourse
  id = "projects/project-f0ad4dfa-b194-4dc6-963/locations/europe-central2/repositories/kubecourse"
}

resource "google_artifact_registry_repository" "kubecourse" {
  repository_id = "kubecourse"
  location      = "europe-central2"
  format        = "DOCKER"
  description   = "Images for the kubecourse app"

  cleanup_policies {
    id     = "keep-2-most-recent"
    action = "KEEP"
    most_recent_versions {
      keep_count = 2
    }
  }

  cleanup_policies {
    id     = "delete-the-rest"
    action = "DELETE"
    condition {
      tag_state = "ANY"
    }
  }
}

import {
  to = google_service_account.github_deployer
  id = "projects/project-f0ad4dfa-b194-4dc6-963/serviceAccounts/github-deployer@project-f0ad4dfa-b194-4dc6-963.iam.gserviceaccount.com"
}
resource "google_service_account" "github_deployer" {
  account_id   = "github-deployer"
  display_name = "GitHub Actions deployer"
}

import {
  to = google_service_account_iam_member.github_wif["csanyilevente8/k8s"]
  id = "projects/project-f0ad4dfa-b194-4dc6-963/serviceAccounts/github-deployer@project-f0ad4dfa-b194-4dc6-963.iam.gserviceaccount.com roles/iam.workloadIdentityUser principalSet://iam.googleapis.com/projects/860228474942/locations/global/workloadIdentityPools/github-pool/attribute.repository/csanyilevente8/k8s"
}
import {
  to = google_service_account_iam_member.github_wif["csanyilevente8/python-backend-project"]
  id = "projects/project-f0ad4dfa-b194-4dc6-963/serviceAccounts/github-deployer@project-f0ad4dfa-b194-4dc6-963.iam.gserviceaccount.com roles/iam.workloadIdentityUser principalSet://iam.googleapis.com/projects/860228474942/locations/global/workloadIdentityPools/github-pool/attribute.repository/csanyilevente8/python-backend-project"
}

import {
  to = google_service_account_iam_member.github_wif["csanyilevente8/go-backend-project"]
  id = "projects/project-f0ad4dfa-b194-4dc6-963/serviceAccounts/github-deployer@project-f0ad4dfa-b194-4dc6-963.iam.gserviceaccount.com roles/iam.workloadIdentityUser principalSet://iam.googleapis.com/projects/860228474942/locations/global/workloadIdentityPools/github-pool/attribute.repository/csanyilevente8/go-backend-project"
}

import {
  to = google_service_account_iam_member.github_wif["csanyilevente8/frontend-project"]
  id = "projects/project-f0ad4dfa-b194-4dc6-963/serviceAccounts/github-deployer@project-f0ad4dfa-b194-4dc6-963.iam.gserviceaccount.com roles/iam.workloadIdentityUser principalSet://iam.googleapis.com/projects/860228474942/locations/global/workloadIdentityPools/github-pool/attribute.repository/csanyilevente8/frontend-project"
}

import {
  to = google_service_account_iam_member.github_wif["csanyilevente8/backend-project"]
  id = "projects/project-f0ad4dfa-b194-4dc6-963/serviceAccounts/github-deployer@project-f0ad4dfa-b194-4dc6-963.iam.gserviceaccount.com roles/iam.workloadIdentityUser principalSet://iam.googleapis.com/projects/860228474942/locations/global/workloadIdentityPools/github-pool/attribute.repository/csanyilevente8/backend-project"
}
resource "google_service_account_iam_member" "github_wif" {
  for_each = toset([
    "csanyilevente8/backend-project",
    "csanyilevente8/frontend-project",
    "csanyilevente8/go-backend-project",
    "csanyilevente8/k8s",
    "csanyilevente8/python-backend-project",
  ])

  service_account_id = google_service_account.github_deployer.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/860228474942/locations/global/workloadIdentityPools/github-pool/attribute.repository/${each.value}"
}