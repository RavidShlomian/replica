#this is a script that installs the dependencies on the instance (amazon linux 2023)

#!/bin/bash

echo "starting user_data script" > /var/log/user-data.log

# Update the system
sudo yum update -y

# Adding the public key for ssh connections
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVnCjzin6qtUXpTkFYV9o4t0UG6is98pH+3pERZN7qwXcOCQ/MfYGmFxo/
uijXOzGcGbQ3R3DGCo/gLYdO55Cysgzer0CrBE+5YDGya+agif6nvot5+/Ea+J6Iw2GqmTxP3g8YNon/DpUAFMxX1/jSzFbwuNi9+t3+F
kHWIzXO5AJsxBLJckrfnkiDJbZu4V2GXqLcT8ofDtHJQVodVVjTuQxYDnQed5rslvo9pLbDqB7zvo7ktWpoY2i2vSUXMAdz7Y96cNy1aq
UmKKheMBm2KtIAfEuuFvPL29ErjAxTL5in7qIqKzbZzadMKshBheGCFi6/SUFFAWtK2OoZfp07" >> /home/ec2-user/.ssh/authorized_keys

# Install Docker
sudo yum install docker -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Pull the latest Nginx image from the public dockerhub (without any need for login)
sudo docker pull nginx:latest

# Download configuration files as raw text from the github repository
sudo curl -o /home/ec2-user/nginx.conf https://raw.githubusercontent.com/RavidShlomian/Moveo-HLS-Task/feature/Terraform/nginx.conf
sudo curl -o /home/ec2-user/Dockerfile https://raw.githubusercontent.com/RavidShlomian/Moveo-HLS-Task/feature/Terraform/Dockerfile
#created directories for debugging with logs from the system
mkdir /home/ec2-user/logs
touch /home/ec2-user/logs/build.txt /home/ec2-user/logs/run.txt

# Build the Docker image with the -f option because the script run from the directory /var/liv/cloud/instances/instance-id/scripts, added logs for debugging
sudo docker build -f /home/ec2-user/Dockerfile -t /home/ec2-user nginx >> /home/ec2-user/logs/build.txt
# Run the Nginx container with the custom configuration file (nginx.conf) as read only beacuse i haven't saw any need for more than that for this scenario, added logs for debugging
sudo docker run --name nginx -d -p 80:80 -v /home/ec2-user/nginx.conf:/etc/nginx/nginx.conf:ro nginx >> /home/ec2-user/logs/run.txt
