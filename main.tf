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

import {
  to = google_container_cluster.kubecourse
  id = "projects/project-f0ad4dfa-b194-4dc6-963/locations/europe-central2-a/clusters/kubecourse"
}

resource "google_container_cluster" "kubecourse" {
  allow_net_admin                          = null
  default_max_pods_per_node                = 110
  deletion_protection                      = true
  description                              = null
  disable_l4_lb_firewall_reconciliation    = false
  enable_cilium_clusterwide_network_policy = false
  enable_fqdn_network_policy               = false
  enable_intranode_visibility              = false
  enable_kubernetes_alpha                  = false
  enable_l4_ilb_subsetting                 = false
  enable_legacy_abac                       = false
  enable_multi_networking                  = false
  enable_shielded_nodes                    = true
  enable_tpu                               = false
  in_transit_encryption_config             = null
  initial_node_count                       = 0
  location                                 = "europe-central2-a"
  logging_service                          = "logging.googleapis.com/kubernetes"
  min_master_version                       = null
  monitoring_service                       = "monitoring.googleapis.com/kubernetes"
  name                                     = "kubecourse"
  network                                  = "projects/project-f0ad4dfa-b194-4dc6-963/global/networks/default"
  networking_mode                          = "VPC_NATIVE"
  node_locations                           = []
  node_version                             = "1.35.8-gke.1036000"
  project                                  = "project-f0ad4dfa-b194-4dc6-963"
  remove_default_node_pool                 = null
  resource_labels                          = {}
  subnetwork                               = "projects/project-f0ad4dfa-b194-4dc6-963/regions/europe-central2/subnetworks/default"
  addons_config {
    dns_cache_config {
      enabled = true
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    network_policy_config {
      disabled = true
    }
  }
  anonymous_authentication_config {
    mode = "LIMITED"
  }
  cluster_autoscaling {
    auto_provisioning_locations = []
    autoscaling_profile         = "BALANCED"
    enabled                     = false
  }
  control_plane_endpoints_config {
    dns_endpoint_config {
      allow_external_traffic = false
      endpoint               = "gke-0a6e0de13ed9480b94c9c1d3c6b81985f8f9-860228474942.europe-central2-a.gke.goog"
    }
    ip_endpoints_config {
      enabled = true
    }
  }
  database_encryption {
    key_name = null
    state    = "DECRYPTED"
  }
  enterprise_config {
  }
  ip_allocation_policy {
    services_ipv4_cidr_block     = "34.118.224.0/20"
    stack_type                   = "IPV4"
    pod_cidr_overprovision_config {
      disabled = false
    }
  }
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "STORAGE", "HPA", "POD", "DAEMONSET", "DEPLOYMENT", "STATEFULSET", "CADVISOR", "KUBELET", "DCGM", "JOBSET"]
    advanced_datapath_observability_config {
      enable_metrics = false
      enable_relay   = false
    }
    managed_prometheus {
      enabled = true
    }
  }
  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
  }
  node_config {
    boot_disk_kms_key           = null
    disk_size_gb                = 100
    disk_type                   = "pd-balanced"
    enable_confidential_storage = false
    flex_start                  = false
    image_type                  = "COS_CONTAINERD"
    labels                      = {}
    local_ssd_count             = 0
    local_ssd_encryption_mode   = null
    logging_variant             = "DEFAULT"
    machine_type                = "e2-medium"
    max_run_duration            = null
    metadata = {
      disable-legacy-endpoints = "true"
    }
    node_group   = null
    oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
    preemptible  = false
    resource_labels = {
      goog-gke-node-pool-provisioning-model = "on-demand"
    }
    resource_manager_tags = {}
    service_account       = "default"
    spot                  = false
    storage_pools         = []
    tags                  = []
    boot_disk {
      disk_type              = "pd-balanced"
      provisioned_iops       = 0
      provisioned_throughput = 0
      size_gb                = 100
    }
    kubelet_config {
      allowed_unsafe_sysctls                 = []
      container_log_max_files                = 0
      container_log_max_size                 = null
      cpu_cfs_quota                          = false
      cpu_cfs_quota_period                   = null
      cpu_manager_policy                     = null
      eviction_max_pod_grace_period_seconds  = 0
      image_gc_high_threshold_percent        = 0
      image_gc_low_threshold_percent         = 0
      image_maximum_gc_age                   = null
      image_minimum_gc_age                   = null
      insecure_kubelet_readonly_port_enabled = "FALSE"
      max_parallel_image_pulls               = 2
      pod_pids_limit                         = 0
      single_process_oom_kill                = false
    }
    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = false
    }
  }
  node_pool {
    initial_node_count = 2
    max_pods_per_node  = 110
    name               = "medium-pool"
    node_count         = 2
    node_locations     = ["europe-central2-a"]
    version            = "1.35.8-gke.1036000"
    autoscaling {
      location_policy      = "BALANCED"
      max_node_count       = 3
      min_node_count       = 2
      total_max_node_count = 0
      total_min_node_count = 0
    }
    management {
      auto_repair  = true
      auto_upgrade = true
    }
    network_config {
      create_pod_range     = false
      enable_private_nodes = false
      pod_ipv4_cidr_block  = "10.124.0.0/14"
      pod_range            = "gke-kubecourse-pods-0a6e0de1"
    }
    node_config {
      boot_disk_kms_key           = null
      disk_size_gb                = 100
      disk_type                   = "pd-balanced"
      enable_confidential_storage = false
      flex_start                  = false
      image_type                  = "COS_CONTAINERD"
      labels                      = {}
      local_ssd_count             = 0
      local_ssd_encryption_mode   = null
      logging_variant             = "DEFAULT"
      machine_type                = "e2-medium"
      max_run_duration            = null
      metadata = {
        disable-legacy-endpoints = "true"
      }
      node_group   = null
      oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
      preemptible  = false
      resource_labels = {
        goog-gke-node-pool-provisioning-model = "on-demand"
      }
      resource_manager_tags = {}
      service_account       = "default"
      spot                  = false
      storage_pools         = []
      tags                  = []
      boot_disk {
        disk_type              = "pd-balanced"
        provisioned_iops       = 0
        provisioned_throughput = 0
        size_gb                = 100
      }
      kubelet_config {
        allowed_unsafe_sysctls                 = []
        container_log_max_files                = 0
        container_log_max_size                 = null
        cpu_cfs_quota                          = false
        cpu_cfs_quota_period                   = null
        cpu_manager_policy                     = null
        eviction_max_pod_grace_period_seconds  = 0
        image_gc_high_threshold_percent        = 0
        image_gc_low_threshold_percent         = 0
        image_maximum_gc_age                   = null
        image_minimum_gc_age                   = null
        insecure_kubelet_readonly_port_enabled = "FALSE"
        max_parallel_image_pulls               = 2
        pod_pids_limit                         = 0
        single_process_oom_kill                = false
      }
      shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
      }
    }
    upgrade_settings {
      max_surge       = 1
      max_unavailable = 0
      strategy        = "SURGE"
    }
  }
  node_pool_auto_config {
    resource_manager_tags = {}
    node_kubelet_config {
      insecure_kubelet_readonly_port_enabled = "FALSE"
    }
  }
  node_pool_defaults {
    node_config_defaults {
      insecure_kubelet_readonly_port_enabled = "FALSE"
      logging_variant                        = "DEFAULT"
    }
  }
  notification_config {
    pubsub {
      enabled = false
      topic   = null
    }
  }
  pod_autoscaling {
    hpa_profile = "PERFORMANCE"
  }
  private_cluster_config {
    enable_private_endpoint     = false
    enable_private_nodes        = false
    private_endpoint_subnetwork = null
    master_global_access_config {
      enabled = false
    }
  }
  rbac_binding_config {
    enable_insecure_binding_system_authenticated   = true
    enable_insecure_binding_system_unauthenticated = true
  }
  release_channel {
    channel = "REGULAR"
  }
  secret_manager_config {
    enabled = false
  }
  security_posture_config {
    mode               = "BASIC"
    vulnerability_mode = "VULNERABILITY_MODE_UNSPECIFIED"
  }
  service_external_ips_config {
    enabled = false
  }
}

import {
  to = google_container_node_pool.medium_pool
  id = "projects/project-f0ad4dfa-b194-4dc6-963/locations/europe-central2-a/clusters/kubecourse/nodePools/medium-pool"
}

resource "google_container_node_pool" "medium_pool" {
  cluster            = "kubecourse"
  initial_node_count = 2
  location           = "europe-central2-a"
  max_pods_per_node  = 110
  name               = "medium-pool"
  node_count         = 2
  node_locations     = ["europe-central2-a"]
  project            = "project-f0ad4dfa-b194-4dc6-963"
  version            = "1.35.8-gke.1036000"
  autoscaling {
    location_policy      = "BALANCED"
    max_node_count       = 3
    min_node_count       = 2
    total_max_node_count = 0
    total_min_node_count = 0
  }
  management {
    auto_repair  = true
    auto_upgrade = true
  }
  network_config {
    create_pod_range     = false
    enable_private_nodes = false
    pod_ipv4_cidr_block  = "10.124.0.0/14"
    pod_range            = "gke-kubecourse-pods-0a6e0de1"
  }
  node_config {
    boot_disk_kms_key           = null
    disk_size_gb                = 100
    disk_type                   = "pd-balanced"
    enable_confidential_storage = false
    flex_start                  = false
    image_type                  = "COS_CONTAINERD"
    labels                      = {}
    local_ssd_count             = 0
    local_ssd_encryption_mode   = null
    logging_variant             = "DEFAULT"
    machine_type                = "e2-medium"
    max_run_duration            = null
    metadata = {
      disable-legacy-endpoints = "true"
    }
    node_group   = null
    oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
    preemptible  = false
    resource_labels = {
      goog-gke-node-pool-provisioning-model = "on-demand"
    }
    resource_manager_tags = {}
    service_account       = "default"
    spot                  = false
    storage_pools         = []
    tags                  = []
    boot_disk {
      disk_type              = "pd-balanced"
      provisioned_iops       = 0
      provisioned_throughput = 0
      size_gb                = 100
    }
    kubelet_config {
      allowed_unsafe_sysctls                 = []
      container_log_max_files                = 0
      container_log_max_size                 = null
      cpu_cfs_quota                          = false
      cpu_cfs_quota_period                   = null
      cpu_manager_policy                     = null
      eviction_max_pod_grace_period_seconds  = 0
      image_gc_high_threshold_percent        = 0
      image_gc_low_threshold_percent         = 0
      image_maximum_gc_age                   = null
      image_minimum_gc_age                   = null
      insecure_kubelet_readonly_port_enabled = "FALSE"
      max_parallel_image_pulls               = 2
      pod_pids_limit                         = 0
      single_process_oom_kill                = false
    }
    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = false
    }
  }
  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
    strategy        = "SURGE"
  }
}