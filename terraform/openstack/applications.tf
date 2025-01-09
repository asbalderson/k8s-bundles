# Copyright 2025 Canonical Ltd.
# See LICENSE file for licensing details.

module "openstack_integrator" {
  source      = "git::https://github.com/charmed-kubernetes/charm-openstack-integrator//terraform?ref=KU-2412/adding-terraform-modules"
  app_name    = module.openstack_integrator_config.config.app_name
  base        = coalesce(module.openstack_integrator_config.config.base, var.k8s.config.base)
  constraints = coalesce(module.openstack_integrator_config.config.constraints, var.k8s.config.constraints)
  channel     = coalesce(module.openstack_integrator_config.config.channel, var.k8s.config.channel)
  model       = var.model
  resources   = module.openstack_integrator_config.config.resources
  revision    = module.openstack_integrator_config.config.revision
  units       = module.openstack_integrator_config.config.units
}

module "cinder_csi" {
  source      = "git::https://github.com/canonical/cinder-csi-operator//terraform?ref=KU-2415/adding-terraform-modules"
  app_name    = module.cinder_csi_config.config.app_name
  base        = coalesce(module.cinder_csi_config.config.base,        module.openstack_integrator_config.config.base,        var.k8s.config.base)
  constraints = coalesce(module.cinder_csi_config.config.constraints, module.openstack_integrator_config.config.constraints, var.k8s.config.constraints)
  channel     = coalesce(module.cinder_csi_config.config.channel,     module.openstack_integrator_config.config.channel,     var.k8s.config.channel)
  model       = var.model
  revision    = module.cinder_csi_config.config.revision
}

module "openstack_cloud_controller" {
  source      = "git::https://github.com/charmed-kubernetes/openstack-cloud-controller-operator//terraform?ref=KU-2413/adding-terraform-modules"
  app_name    = module.openstack_cloud_controller_config.config.app_name
  base        = coalesce(module.openstack_cloud_controller_config.config.base,        module.openstack_integrator_config.config.base,        var.k8s.config.base)
  constraints = coalesce(module.openstack_cloud_controller_config.config.constraints, module.openstack_integrator_config.config.constraints, var.k8s.config.constraints)
  channel     = coalesce(module.openstack_cloud_controller_config.config.channel,     module.openstack_integrator_config.config.channel,     var.k8s.config.channel)
  model       = var.model
  revision    = module.openstack_cloud_controller_config.config.revision
}
