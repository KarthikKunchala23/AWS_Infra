# resource "aws_lb" "vproapp-elb" {
#   name               = "vproapp-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.ecs_sg.id]
#   subnets            = [aws_subnet.ecs_subnet.id]

#   enable_deletion_protection = false

# #   access_logs {
# #     bucket  = aws_s3_bucket.lb_logs.id
# #     prefix  = "test-lb"
# #     enabled = true
# #   }

#   tags = {
#     Environment = "production"
#   }
# }

# resource "aws_lb_target_group" "alb-vproapp-tg" {
#   name        = "tf-example-lb-alb-tg"
#   target_type = "alb"
#   port        = 80
#   protocol    = "TCP"
#   vpc_id      = aws_vpc.ecs_vpc.id
# }