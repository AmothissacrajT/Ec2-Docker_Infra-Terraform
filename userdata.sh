dnf update -y
dnf install -y docker
systemctl start docker
systemctl enable docker
groupadd docker 
usermod -aG docker ec2-user
