output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}

output "nat_gateway_ip" {
  value = module.network.nat_gateway_ip
}
