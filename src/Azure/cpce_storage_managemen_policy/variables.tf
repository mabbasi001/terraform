variable "storage_account_id" {
  description = "The id of the storage account."
  type        = string
}

variable "name" {
  description = "The override name for the resource."
  type        = string
  default     = null
}

variable "name_suffix" {
  description = "The suffix to be appended to the auto-generated name of the resource."
  type        = string
  default     = null
}

variable "blob_types" {
  description = "List of blob types, expects; appendBlob, blockBlob - defaults to appendBlob"
  type        = list(string)
  default     = ["appendBlob"]
}

variable "container_filter_prefix" {
  description = "The prefix of blobs to filter."
  type        = list(string)
  default     = null
}

variable "delete_blobs_after_last modified_in_days" {
  description = "Number of days since modification after which blobs are deleted - defaults to 7."
  type        = number
  default     = 7
}

variable "delete_blobs_after_last_access_time_in_days" {
  description = "Number of days since last access after which blobs are deleted - defaults to -1 (off)."
  type        = number
  default     = -1
}

variable "delete_blobs_after_creation_time_in_days" {
  description = "Number of days since creation after which blobs are deleted - defaults to -1 (off)."
  type        = number
  default     = -1
}

variable "delete_snapshot_after_creation_time_in_days" {
  description = "Number of days since creation after which snapshots are deleted - defaults to -1 (off)."
  type        = number
  default     = -1
}

variable "delete_version_after_creation_time_in_days" {
  description = "Number of days since creation after which version are deleted - defaults to -1 (off)."
  type        = number
  default     = -1
}
