#Security Group
resource "aws_security_group" "All-traffic-dockerSG" {
  name = "All-traffic-DockerSG"
  description = "Allow all traffic inbound"
  vpc_id = aws_vpc.DockerVpc.id

  tags = {
    Name = "All-traffic-DockerSG"
  }
}

#Ingress rules
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.All-traffic-dockerSG.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port =  80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.All-traffic-dockerSG.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.All-traffic-dockerSG.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}


#Docker Ec2-1
resource "aws_instance" "Docker-ec2-1" {
  ami = "ami-08e3b3155fc937a94"
  subnet_id = aws_subnet.Subnet1-Public.id
  instance_type = "t3.micro"
  key_name = "webserver_key"
  vpc_security_group_ids = [aws_security_group.All-traffic-dockerSG.id]
  associate_public_ip_address = true

  user_data = file(var.user_data_path)
  tags = {
    Name = "Docker-ec2-1"
  }
}

#Docker Ec2-2
resource "aws_instance" "Docker-ec2-2" {
  ami = "ami-08e3b3155fc937a94"
  subnet_id = aws_subnet.Subnet2-Public.id
  instance_type = "t3.micro"
  key_name = "webserver_key"
  vpc_security_group_ids = [aws_security_group.All-traffic-dockerSG.id]
  associate_public_ip_address = true

  user_data = file(var.user_data_path)
  tags = {
    Name = "Docker-ec2-2"
  }
}

#User data
