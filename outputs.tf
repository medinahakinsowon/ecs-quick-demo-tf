output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.subnet[*].id
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_service_name" {
  value = aws_ecs_service.main.name
}

output "load_balancer_dns" {
  value = aws_lb.main.dns_name
}

output "route53_record" {
  value = aws_route53_record.main.fqdn
}
