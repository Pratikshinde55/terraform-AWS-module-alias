# This project helps to use Terraform Alias for Custom Module

## Alias :
 Terraform Alias is use for creating multi-region providers.


I create Module folder for AWS EC2 instance(aws_instance), AWS amazon machine image retrieve data source(aws_ami), AWS VPC resource(aws-vpc) with Subnet with dynamic subnet availability zone from alias/provider, 
AWS Security group resource(aws_security_group) which is connected to my custom VPC.


## I call module from TeamB:
1st need to initialize and then apply terraform command.

     terraform init

![Terraform-init-cmd](https://github.com/user-attachments/assets/ecffc38c-2341-49db-bf02-6c0a08b54e29)

Terraform apply command for apply terraform file:

    terraform apply -auto-approve

![Terraform-apply-cmd](https://github.com/user-attachments/assets/2613518a-4589-4a71-934c-aec86a277445)
![Terraform-apply-cmd](https://github.com/user-attachments/assets/da8a2a7f-0647-449e-934c-6abfccad71a8)

In the only one folder i can create two differnet region Infrastucture using only on command.


