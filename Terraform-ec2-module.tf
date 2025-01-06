data "aws_ami" "ps-ami-block" {
    most_recent = "true"
    owners = ["amazon"]

    filter {
      name = "name"
      values = ["al2023-ami-*-x86_64"]
    }
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    } 
}


resource "aws_instance" "ps-instance-block" {
    ami = data.aws_ami.ps-ami-block.id
    instance_type = var.Instance-Type
    # key_name = "psTerraform-key"
    vpc_security_group_ids = [ aws_security_group.ps-SG-block.id ]
    associate_public_ip_address = true 
    subnet_id = aws_subnet.ps-subnet-block.id
    tags = {
       Name = var.Instance-Name
    }
    depends_on =  [
         data.aws_ami.ps-ami-block ,
         aws_security_group.ps-SG-block ,
         aws_vpc.ps-vpc-block
    ]
}

variable "Instance-Type" {
      
}
variable "Instance-Name" {
     type = string    
}


resource "aws_security_group" "ps-SG-block" {
     name = "TF-${var.sgName}"
     description = "This SG from Terraform"
     vpc_id = aws_vpc.ps-vpc-block.id
    
     dynamic "ingress" {
        for_each = var.Allow-TCP
        iterator = x
        content {
            from_port = x.value
            to_port = x.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
         }
      }
      egress {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
      }
      
}


variable "sgName"{
     type = string
    
}

variable "Allow-TCP" {
     type = list(number)
     
}

####  vpc

resource "aws_vpc" "ps-vpc-block" {
     cidr_block = "10.0.0.0/16"
     tags = {
        Name = var.VPC_NAME
     }
}

variable "VPC_NAME" {
    type = string
  
}

### Declare availability zone for subnet ######### "This will dynamically fetch a valid availability zone in the specified region."

data "aws_availability_zones" "available" {
}

resource "aws_subnet" "ps-subnet-block" {
  

  vpc_id                  = aws_vpc.ps-vpc-block.id
  cidr_block              = "10.0.1.0/24"  
  availability_zone       =  data.aws_availability_zones.available.names[0]                ## This ensures that the subnet is created in the first available availability zone in the region, Help dynamic region
  map_public_ip_on_launch = true
  
  tags = {
    Name = "ps-subnet-block"
  }
  depends_on = [
     aws_vpc.ps-vpc-block  
  ] 
}

