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
  location = "europe-central2"
  format = "DOCKER"
  description = "Images for the kubecourse app"

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