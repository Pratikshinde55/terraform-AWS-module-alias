# This project helps to use Terraform Alias for Custom Module

## Alias :
 Terraform Alias is use for creating multi-region providers.


I create Module folder for AWS EC2 instance(aws_instance), AWS amazon machine image retrieve data source(aws_ami), AWS VPC resource(aws-vpc) with Subnet with dynamic subnet availability zone from alias/provider, 
AWS Security group resource(aws_security_group) which is connected to my custom VPC.

## Terraform module:

![Module-block-1](https://github.com/user-attachments/assets/01b78245-4aee-42cd-9795-beb6bdf91706)
![Module-block-2](https://github.com/user-attachments/assets/54fdb5cf-815c-4233-a18d-8003135371d7)
![Module-block-3](https://github.com/user-attachments/assets/9b91a606-9702-4ad6-a74c-3c5137dd55ed)


## Teraform main.tf:

![image](https://github.com/user-attachments/assets/b0a15c0d-4b71-48d2-895f-601f02b51b2f)


## I call module from TeamB:
1st need to initialize and then apply terraform command.


     terraform init

![Terraform-init-cmd](https://github.com/user-attachments/assets/ecffc38c-2341-49db-bf02-6c0a08b54e29)

Terraform apply command for apply terraform file:

    terraform apply --auto-approve

![Terraform-apply-cmd](https://github.com/user-attachments/assets/2613518a-4589-4a71-934c-aec86a277445)
![Terraform-apply-cmd](https://github.com/user-attachments/assets/da8a2a7f-0647-449e-934c-6abfccad71a8)

In the only one folder i can create two differnet region Infrastucture using only on command.


## On AWS Console Infrastucture is created:

- EC2 Instances and Security group on Mumbai

![AWS-EC2](https://github.com/user-attachments/assets/d42eef2f-2109-4f42-b078-1a6ce586eb9d)
![AWS-EC2-SG](https://github.com/user-attachments/assets/d350d9a4-32bb-46b8-a8d7-bbff6e64bd86)

- EC2 Instances and Security group on Verginia

![AWS-EC2-2](https://github.com/user-attachments/assets/cf39d33b-db97-47f3-b60b-0fe88658aebb)
![AWS-EC2-SG-2](https://github.com/user-attachments/assets/43e567ac-b3ff-4630-9359-1b359f255671)

- VPC for Verginia
  
![VPC-Verginia-1](https://github.com/user-attachments/assets/4a263dc3-795e-4ccb-bc2b-1a477dd912cb)
![VPC-subnet-1](https://github.com/user-attachments/assets/cad601a2-78e4-4bb0-bbf6-4b123f3269d8)


- VPC for Mumbai
  
![VPC-mumbai](https://github.com/user-attachments/assets/4ef4db62-cacd-4c99-b28b-5462fc43aaf7)
![VPC-SUBNET](https://github.com/user-attachments/assets/82d12d7c-7b86-4ac5-995a-eb25e3f20495)




