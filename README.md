# terraform-app-load-balance

In this terraform/aws script we build a setup with an application load balancer. We will end up with following resources:

  - one app load balancer that redirect traffic into two public subnets
  - two management instances each in a different public subnet
  - two webserver instances each in a different private subnet

Prerequisites
-----------------------
  - Terraform
  - AWS CLI
   
Installation && Running
-----------------------

Do a git clone of the project:

	git clone https://github.com/dcc6fvo/terraform-basic-setup 
	
Change key-pair field of aws-instances with your current keys!

Access the newly created folder with the git clone command and type the following command:

	terraform init

Then creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure:

  	terraform plan
  
Finally, the command that executes the actions proposed in a terraform plan (it is used to deploy your infrastructure):

  	terraform apply -auto-approve

To destroy all the configurations:

	terraform destroy
