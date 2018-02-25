resource "aws_ecs_cluster" "docker-demo" {
    name = "${var.ecs_cluster}"
}