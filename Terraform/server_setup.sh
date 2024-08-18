#!/bin/bash
set -x
echo "starting user_data script" > /var/log/user-data.log

# Update the system
sudo yum update -y

# Adding the public key for ssh connections
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVnCjzin6qtUXpTkFYV9o4t0UG6is98pH+3pERZN7qwXcOCQ/MfYGmFxo/
uijXOzGcGbQ3R3DGCo/gLYdO55Cysgzer0CrBE+5YDGya+agif6nvot5+/Ea+J6Iw2GqmTxP3g8YNon/DpUAFMxX1/jSzFbwuNi9+t3+F
kHWIzXO5AJsxBLJckrfnkiDJbZu4V2GXqLcT8ofDtHJQVodVVjTuQxYDnQed5rslvo9pLbDqB7zvo7ktWpoY2i2vSUXMAdz7Y96cNy1aq
UmKKheMBm2KtIAfEuuFvPL29ErjAxTL5in7qIqKzbZzadMKshBheGCFi6/SUFFAWtK2OoZfp07" >> /home/ec2-user/.ssh/authorized_keys

# Create files for testing
touch /home/ec2-user/abc.txt
touch /home/ec2-user/abcdf.txt

# Install Docker
sudo yum install docker -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Pull the latest Nginx image
sudo docker pull nginx:latest

# Download configuration files
curl -o /home/ec2-user/nginx.conf https://raw.githubusercontent.com/RavidShlomian/Moveo-HLS-Task/feature/Terraform/nginx.conf
curl -o /home/ec2-user/Dockerfile https://raw.githubusercontent.com/RavidShlomian/Moveo-HLS-Task/feature/Terraform/Dockerfile

# Build the Docker image with the -f option because the script run from the directory /var/liv/cloud/instances/instance-id/scripts 
sudo docker build -f /home/ec2-user/Dockerfile -t /home/ec2-user nginx
# Run the Nginx container with the custom configuration
sudo docker run --name nginx -d -p 80:80 -v /home/ec2-user/nginx.conf:/etc/nginx/nginx.conf:ro nginx
