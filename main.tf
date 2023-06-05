module "vpc" {
       source = "git::https://github.com/sameeryalla/tf-module-vpc.git"
       for_each = var.vpc
       cidr_block = each.value["cidr_block"]
       subnets = each.value["subnets"]
       tags = local.tags
       env = var.env
}

module "app" {
       source = "git::https://github.com/sameeryalla/tf-module-app.git"

       for_each = var.app
       name = each.value["name"]
       instance_type = each.value["instance_type"]
       desired_capacity = each.value["desired_capacity"]
       max_size = each.value["max_size"]
       min_size = each.value["min_size"]
       bastion_cidr = var.bastion_cidr

       env=var.env


       subnet_ids = lookup(lookup(lookup(lookup(module.vpc, main, null),"subnets",null),each.value["subnet_name"],null),"subnet_ids",null)
       vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
       allow_app_cidr =lookup(lookup(lookup(lookup(module.vpc, main, null),"subnets",null),each.value["allow_app_cidr"],null),"subnet_cidrs",null)



}
