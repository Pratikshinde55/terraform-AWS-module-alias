# This project helps to use Terraform Alias for Custom Module

## Alias :
 Terraform Alias is use for creating multi-region providers.

## Why Use Aliases?: 
Aliases allow us to specify which provider configuration to use when creating resources in different regions or with different credentials. For example,
if i want to create an EC2 instance in Mumbai and another one in North Virginia, I would use the aliases mumbai-PS and Nverginia-PS to differentiate them. 

## Multiple Providers:
 By using aliases, We can have multiple provider blocks in the same configuration for different AWS regions (or different AWS accounts).
 In my case, I've defined two providers for two different regions: ap-south-1 (Mumbai) and us-east-1 (North Virginia
 
- Set-up overview:
  
I create Module folder for AWS EC2 instance(aws_instance), AWS amazon machine image retrieve data source(aws_ami), AWS VPC resource(aws-vpc) with Subnet with dynamic subnet availability zone from alias/provider, 
AWS Security group resource(aws_security_group) which is connected to my custom VPC.

## Terraform module:

![Module-block-1](https://github.com/user-attachments/assets/01b78245-4aee-42cd-9795-beb6bdf91706)
**vpc_security_group_ids = [ aws_security_group.ps-SG-block.id ]** --> This associates the instance with a security group.

**associate_public_ip_address = true** --> This ensures that the EC2 instance will be assigned a public IP address. By default,
If the instance is launched in a public subnet and associate_public_ip_address is true, the instance will get a public IP.

**subnet_id = aws_subnet.ps-subnet-block.id** --> This ensures the instance is launched in a specific subnet within the VPC.

**depends_on = [...]** --> Meta argument This ensures that certain resources are created before the EC2 instance is launched.

![Module-block-2](https://github.com/user-attachments/assets/54fdb5cf-815c-4233-a18d-8003135371d7)

**vpc_id = aws_vpc.ps-vpc-block.id** --> here security group is associated with a specific VPC (Virtual Private Cloud). 

**dynamic "ingress" {}** --> The ingress block defines the inbound rules for the security group. In this case, 
I am using a dynamic block to create multiple inbound rules based on a list of ports provided via var.Allow-TCP.

**egress {}** --> This defines the outbound rules for the security group, the traffic allowed from your EC2 instance to outside.

![Module-block-3](https://github.com/user-attachments/assets/9b91a606-9702-4ad6-a74c-3c5137dd55ed)

**data "aws_availability_zones" "available"** --> This is a data source that retrieves information about the availability zones in the selected AWS region.

**aws_subnet** --> This defines a new subnet within the VPC.

**availability_zone = data.aws_availability_zones.available.names[0]** -->  This dynamically assigns the availability zone to the subnet.
It selects the first availability zone from the list provided by the aws_availability_zones data source.

**data.aws_availability_zones.available.names[0]** --> This fetches the first availability zone in the region.This will use the first available zone (EX: us-east-1a)

**map_public_ip_on_launch = true**  -->  This enables the automatic assignment of public IP addresses to instances launched in this subnet.


## Teraform main.tf:

![image](https://github.com/user-attachments/assets/b0a15c0d-4b71-48d2-895f-601f02b51b2f)

**profile = "tfPratik"** -->  The AWS CLI profile to use for credentials.


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

- EC2 Instances and Security group on N.Virginia region:

![AWS-EC2](https://github.com/user-attachments/assets/d42eef2f-2109-4f42-b078-1a6ce586eb9d)
![AWS-EC2-SG](https://github.com/user-attachments/assets/d350d9a4-32bb-46b8-a8d7-bbff6e64bd86)

- EC2 Instances and Security group on Mumbai region:

![AWS-EC2-2](https://github.com/user-attachments/assets/cf39d33b-db97-47f3-b60b-0fe88658aebb)
![AWS-EC2-SG-2](https://github.com/user-attachments/assets/43e567ac-b3ff-4630-9359-1b359f255671)

- VPC & Subnet for North Virginia region:
  
![VPC-Verginia-1](https://github.com/user-attachments/assets/4a263dc3-795e-4ccb-bc2b-1a477dd912cb)
![VPC-subnet-1](https://github.com/user-attachments/assets/cad601a2-78e4-4bb0-bbf6-4b123f3269d8)


- VPC & Subnet for Mumbai region:
  
![VPC-mumbai](https://github.com/user-attachments/assets/4ef4db62-cacd-4c99-b28b-5462fc43aaf7)
![VPC-SUBNET](https://github.com/user-attachments/assets/82d12d7c-7b86-4ac5-995a-eb25e3f20495)


## Terraform destroy command destroy entire infrastucture in one command:

     terraform destroy

![Terra-destroy-cmd](https://github.com/user-attachments/assets/2d25a542-7648-4c69-a801-ce6a9e9b670b)

