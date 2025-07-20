# need to create key pair (login)
resource aws_key_pair my_key {
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
}

# need to create VPC & Security Group
resource aws_default_vpc default {}

resource aws_security_group my_security_group {
    name = "automate-sg"
    description = "This will add a TF generate Security group"
    vpc_id = aws_default_vpc.default.id

    # inbound rules for port 22
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH Open"
    }

    # inbound rules for port 80
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP Open"
    }

    # outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "all access open outbound"
    }

    tags = {
        Name = "automate-sg"
    }
}

# Create ec2 instance
resource "aws_instance" "my_instance" {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = "t2.micro"
    ami = "ami-0f918f7e67a3323f0"  # ubuntu
    root_block_device {
      volume_size = 12
      volume_type = "gp3"
    }

    tags = {
      Name = "Master"
    }
}

# Output the EC2 instance public IP
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
  description = "Public IP of the EC2 instance"
}
