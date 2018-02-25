output "vpc_id" {
    value = "${aws_vpc.ecs_cluster_vpc.id}"
}

output "load_balancer_name" {
    value = "${aws_alb.ecs-load-balancer.name}"
}

output "target_group_arn" {
    value = "${aws_alb_target_group.ecs-target-group.arn}"
}