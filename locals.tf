locals {
  #name defaults
  name_default = "${var.envname}-${var.envtype}-${var.profile}"
  name_prefix  = "${var.name_override=="" ? local.name_default:var.name_override}"

  #tag defaults
  tag_name            = "${lookup(var.resource_tags,"envname",var.envname)}-${var.profile}"
  tag_environmentname = "${lookup(var.resource_tags,"envname",var.envname)}"
  tag_profile         = "${var.profile}"
}
