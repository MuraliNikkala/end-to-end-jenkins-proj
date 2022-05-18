provider "aws" {
    region = "us-east-1"
}

data "aws_ami" "my_ami" {
     most_recent      = true
     #name_regex       = "^mavrick"
     owners           = ["747068662246"]
}


resource "aws_instance" "web-1" {
    ami = "${data.aws_ami.my_ami.id}"
    #ami = "ami-0d857ff0f5fc4e03b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "NVWEBSERVER2-NIT-Key"
    subnet_id = "subnet-06bd1be4d3a6e47de"
	#private_ip = "10.1.1.111"
    vpc_security_group_ids = ["sg-084b42dc4c9669219"]
    associate_public_ip_address = true	
    tags = {
        Name = "Server-1"
        Env = "Prod"
        Owner = "Sree"
    }
}
