/* !!! Changing any of the parameters below will trigger password re-generation on all depending resources
such as VMs, AAA credentials, etc.,resulting in TF recreating and/or updating them.
If different password complexity is required, then a new random_password module needs creating. !!! */

resource "random_password" "cpce_random_password" {
  length      = 20
  lower       = true
  min_lower   = 2
  upper       = true
  min_upper   = 2
  numeric      = true
  min_numeric = 2
  special     = true
  min_special = 2
}