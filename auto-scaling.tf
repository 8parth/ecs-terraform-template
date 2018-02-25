resource "aws_launch_configuration" "ecs-launch-configuration" {
    name = "ecs-launch-configuration"
    image_id = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    iam_instance_profile = "${aws_iam_instance_profile.ecs-instance-profile.id}"

    root_block_device {
      volume_type = "standard"
      volume_size = 30
      delete_on_termination = true
    }

    lifecycle {
        create_before_destroy = true
    }

    security_groups = ["${aws_security_group.public_sg.id}"]
    associate_public_ip_address = true
    key_name = "${var.aws_key_name}"
    user_data = <<EOF
                #!bin/bash
                echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
                EOF
}

resource "aws_autoscaling_group" "ecs-autoscaling-group" {
    name = "ecs-autoscaling-group"
    max_size = "${var.max_instance_size}"
    min_size = "${var.min_instance_size}"
    desired_capacity = "${var.desired_capacity}"
    vpc_zone_identifier = ["${aws_subnet.us-east-1a-public.id}", "${aws_subnet.us-east-1b-public.id}"]
    launch_configuration = "${aws_launch_configuration.ecs-launch-configuration.name}"
    health_check_type = "ELB"
}