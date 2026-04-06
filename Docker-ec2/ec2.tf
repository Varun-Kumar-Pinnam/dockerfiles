resource "aws_instance" "bastion" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.sg_id]
  iam_instance_profile = aws_iam_instance_profile.eks.name
  user_data              = file("docker.sh")

  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true

    # EBS volume tags
    tags = {
      Name = "Docker"
    }
  }

    tags = {
      Name = "Docker"
    }
    
}

# Create an Instance Profile (Only for EC2)
resource "aws_iam_instance_profile" "eks" {
  name = "eks"
  role = local.iam_role
}

