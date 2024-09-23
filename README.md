# AWS_Infra
Provisioning AWS Infra using Terraform for DevOps work scenarios

1. Created ECR Repo private repository for storing the Docker Images
2. Implemented the ECS Cluster with Task definition and service 
3. Created VPC, Subnets and Security Group
4. ECS Containers are deployed in subnets within the VPC
5. A load Balancer was created which routes traffic to target group where ECS Containers are as targets
6. ECS Containers are not open for internet load balancer will route traffic from internet to containers created in same VPC and subnets. 