/**
 * # Fortigate Policy configuration module
 *
 * This terraform module configures Policy on a firewall
 */
terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
    }
  }
}
locals {
  vdom_policy_yaml = {
    for vdom in var.vdoms : vdom => yamldecode(file("${var.config_path}/config/${vdom}/rules.yaml")) if fileexists("${var.config_path}/config/${vdom}/rules.yaml")
  }


  policy = flatten([
      for vdom in var.vdoms : [
        for policy in try(local.vdom_policy_yaml[vdom].policy, []) :  merge(policy, {vdomparam = vdom})
      ]
  ])
}

resource fortios_firewall_policy policy {
  for_each                    = { for policy in local.policy : policy.name => policy}
  name                        = each.value.name
  action                      = each.value.action
  vdomparam                   = each.value.vdomparam
  logtraffic                  = try(each.value.log, "all")
  internet_service            = can(each.value.internet_service) ? "enable" : "disable"
  internet_service6           = can(each.value.internet_service6) ? "enable" : "disable"
  nat                         = try(each.value.nat, "disable")
  comments                    = "Terraform"

  dynamic dstaddr {
    for_each    = { for dstaddr in try(each.value.dstaddr, []) : dstaddr => dstaddr}
    content {
      name      = dstaddr.value
    }
  }
  dynamic dstaddr6 {
    for_each    = { for dstaddr6 in try(each.value.dstaddr6, []) : dstaddr6 => dstaddr6}
    content {
      name      = dstaddr6.value
    }
  }
  dynamic dstintf {
    for_each    = { for dstintf in try(each.value.dstintf, []) : dstintf => dstintf}
    content {
      name      = dstintf.value
    }
  }

  dynamic service {
    for_each    = { for service in try(each.value.service, []) : service => service}
    content {
      name      = service.value
    }
  }

  dynamic internet_service_name {
    for_each    = { for internet_service_name in try(each.value.internet_service, []) : internet_service_name => internet_service_name}
    content {
      name      = internet_service_name.value
    }
  }
  dynamic internet_service6_name {
    for_each    = { for internet_service6_name in try(each.value.internet_service6, []) : internet_service6_name => internet_service6_name}
    content {
      name      = internet_service6_name.value
    }
  }

  dynamic srcaddr {
    for_each    = { for srcaddr in try(each.value.srcaddr, []) : srcaddr => srcaddr}
    content {
      name      = srcaddr.value
    }
  }
  dynamic srcaddr6 {
    for_each    = { for srcaddr6 in try(each.value.srcaddr6, []) : srcaddr6 => srcaddr6}
    content {
      name      = srcaddr6.value
    }
  }
  dynamic srcintf {
    for_each    = { for srcintf in try(each.value.srcintf, []) : srcintf => srcintf}
    content {
      name      = srcintf.value
    }
  }
}
