resource "aws_alb" "ecs-load-balancer" {
    name = "ecs-load-balancer"
    security_groups = ["${aws_security_group.public_sg.id}"]
    subnets = ["${aws_subnet.us-east-1a-public.id}", "${aws_subnet.us-east-1b-public.id}"]

    tags {
        Name = "ecs-load-balancer"
        Terraform = true
    }
}

resource "aws_alb_target_group" "ecs-target-group" {
    name = "ecs-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = "${aws_vpc.ecs_cluster_vpc.id}"

    health_check {
        healthy_threshold = "5"
        unhealthy_threshold = "2"
        interval = "30"
        matcher = "200"
        path = "/"
        port = "traffic-port"
        protocol = "HTTP"
        timeout = "5"
    }

    tags {
        Name = "ecs-target-group"
        Terraform = true
    }
}

resource "aws_alb_listener" "alb-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port = 80
    protocol = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.ecs-target-group.arn}"
        type = "forward"
    }
}