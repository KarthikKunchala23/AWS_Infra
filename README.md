# AWS_Infra
Provisioning AWS Infra using Terraform for DevOps work scenarios

1. Created ECR Repo private repository for storing the Docker Images
2. Implemented the ECS Cluster with Task definition and service 
3. Created VPC, Subnets and Security Group
4. ECS Containers are deployed in subnets within the VPC
5. A load Balancer was created which routes traffic to target group where ECS Containers are as targets
6. ECS Containers are not open for internet load balancer will route traffic from internet to containers created in same VPC and subnets. 
7. Introduced new Terraform Configuration files in CICD and ECR directories.
8. CICD directory contains terraform configuration for provisioning the infrastructure of Code pipeline, Code build, Code deploy and Code star connections along with ECS Cluster creation with task definition and service, which are deployed in vpc accessed through aws application load balancer with two target groups blue/green (as we are deploying containers with blue/green deployment).
9. I've a sample nodejs application where I've mentioned buildspec.yml and appspec.yml files for code build and code deploy configurations url for github repo of nodejs app: https://github.com/KarthikKunchala23/nodecicd.git.
10. In ECR directory you can get Terraform configurations for provisioning ECR private registry.