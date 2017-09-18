locals {
  #name defaults
  name_default = "${var.envname}-${var.profile}"
  name_prefix  = "${var.name_override=="" ? local.name_default:var.name_override}"

  #tag defaults
  tag_name            = "${lookup(var.resource_tags,"envname",var.envname)}-${var.profile}"
  tag_environmentname = "${lookup(var.resource_tags,"envname",var.envname)}"
  tag_profile         = "${var.profile}"

  #all default tags merged into single map
  tag_default_all = "${merge(map("Name", local.tag_name),map("EnvironmentName", local.tag_environmentname),map("Profile", local.tag_profile))}"

  #default and custom tags merged in to single variable map
  tags = "${merge(local.tag_default_all,var.custom_resource_tags)}"
}
