# Moveo-HLS-Task
Home Assignment for Moveo DevSecOps position.

Dear Reviewer, I hope this finds you well.

I'll start from the end to the beginning, you can't view the final result in your computer. 
The reason for that derives from the fact that my GitHub Actions doesn't write properly to the tf.state file
in the remote backend (s3 bucket).

Iv'e created and stored credentials of an IAM user in the GitHub Secrets, but it doesn't work. 
Also i was about to output the load balancer dns_name attribute for you to review and paste in your browser, but that 
function didn't work too.

Iv'e sent stav the screenshots of the successfull initialization of the project and hope you consider it.

Now for the project itself :)

The main components are: EC2 Instance (deployment), Bastion Host (for accessing the instance), ALB, Dockerfile, GitHub Actions yaml, VPC, S3 Bucket for remote backend, Private subnet and 2 public subnets.

The EC2 instance for deployment is behind private subnet and with the required dependencies. 
In order to acccess it, Iv'e used a bastion host in the same vpc.
Utillized ALB with Target group and listener to access the application from outside.
To ensure Team collaboration Iv'e setted the backend as remote in a dedicated S3 bucket.