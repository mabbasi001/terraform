locals {
  eventgrid_topic_id     = var.eventgrid_topic_id
  event_delivery_schema  = var.event_delivery_schema
  expiration_time_utc    = var.expiration_time_utc
  included_event_types   = var.included_event_types
  subject_filter         = var.subject_filter
  retry_policy           = var.retry_policy
  dead_letter_endpoint   = var.dead_letter_endpoint
  storage_queue_endpoint = var.storage_queue_endpoint
  name = var.name != null ? var.name : lower(format("evsub%s%s%s",
    var.customer_code != null ? "-${var.customer_code}" : "",
    var.environment_code != null ? "-${var.environment_code}" : "",
  var.name_suffix != null ? "-${var.name_suffix}" : ""))

}

resource "azurerm_eventgrid_event_subscription" "eventgrid_event_subscription" {
  name                  = local.name
  scope                 = local.eventgrid_topic_id
  event_delivery_schema = local.event_delivery_schema
  expiration_time_utc   = local.expiration_time_utc
  included_event_types  = local.included_event_types

  dynamic "retry_policy" {
    for_each = local.retry_policy == null ? [] : list(local.retry_policy)

    content {
      max_delivery_attempts = retry_policy.value.max_delivery_attempts
      event_time_to_live    = retry_policy.value.event_time_to_live
    }
  }

  dynamic "subject_filter" {
    for_each = local.subject_filter == null ? [] : list(local.subject_filter)

    content {
      subject_begins_with = subject_filter.value.subject_begins_with
      subject_ends_with   = subject_filter.value.subject_ends_with
      case_sensitive      = subject_filter.value.case_sensitive != null ? subject_filter.value.case_sensitive : false
    }
  }

  storage_blob_dead_letter_destination {
    storage_account_id          = local.dead_letter_endpoint.storage_account_id
    storage_blob_container_name = local.dead_letter_endpoint.blob_container_name
  }

  storage_queue_endpoint {
    storage_account_id = local.storage_queue_endpoint.storage_account_id
    queue_name         = local.storage_queue_endpoint.queue_name
  }
}
