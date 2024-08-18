  #!/bin/bash
  set -x
  echo "starting user_data script" > /var/log/user-data.log

  sudo apt-get update -y
  #Adding the public key for ssh connections 
  echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVnCjzin6qtUXpTkFYV9o4t0UG6is98pH+3pERZN7qwXcOCQ/MfYGmFxo/
  uijXOzGcGbQ3R3DGCo/gLYdO55Cysgzer0CrBE+5YDGya+agif6nvot5+/Ea+J6Iw2GqmTxP3g8YNon/DpUAFMxX1/jSzFbwuNi9+t3+F
  kHWIzXO5AJsxBLJckrfnkiDJbZu4V2GXqLcT8ofDtHJQVodVVjTuQxYDnQed5rslvo9pLbDqB7zvo7ktWpoY2i2vSUXMAdz7Y96cNy1aq
  UmKKheMBm2KtIAfEuuFvPL29ErjAxTL5in7qIqKzbZzadMKshBheGCFi6/SUFFAWtK2OoZfp07" >> /home/ubuntu/.ssh/authorized_keys
  touch abc.txt
  #install docker on the machine
  sudo apt-get install docker.io -y
  touch abcdf.txt
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo docker pull nginx:latest
  curl -o /home/ubuntu/nginx.conf https://raw.githubusercontent.com/RavidShlomian/Moveo-HLS-Task/feature/Terraform/nginx.conf
  curl -o /home/ubuntu/Dockerfile https://raw.githubusercontent.com/RavidShlomian/Moveo-HLS-Task/feature/Terraform/Dockerfile
  sudo docker run --name nginx -d -p 80:80 -v /home/ubuntu/nginx.conf:/etc/nginx/nginx.conf:ro nginx
  
