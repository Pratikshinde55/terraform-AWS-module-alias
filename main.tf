terraform {
   required_providers {
       aws = {
         source = "hashicorp/aws"
         version = "~> 5.82"
       }
    
     }    
}

 ## alias for mumbai region
 
provider "aws" {
   alias = "mumbai-PS"
   region = "ap-south-1"
   profile =  "tfPratik"
    
}

  ## Alias for N.verginia region
  
provider "aws" {
    alias = "Nverginia-PS"
    region = "us-east-1"
    profile = "tfPratik"
}


########## Module calling with Dynamic Region with the help of Terraform Alias

module "TeamB-Block" {

   source = "../module-ec2/module/"

   Instance-Name = "EC2-by-Teamb"
   Instance-Type = "t2.nano"
   sgName = "SG-BY_Teamb"
   Allow-TCP = [22, 80]
   VPC_NAME = "VPC-by-Teamb"
   
   providers = {
    aws = aws.Nverginia-PS
  }
}  

########## Module calling with Dynamic Region with the help of Terraform Alias

module "TeamB-Block-2nd" {

   source = "../module-ec2/module/"

   Instance-Name = "EC2-by-Teamb"
   Instance-Type = "t2.nano"
   sgName = "SG-BY_Teamb"
   Allow-TCP = [22, 80]
   VPC_NAME = "VPC-by-Teamb"
   
   providers = {
    aws = aws.mumbai-PS
  }
}  
