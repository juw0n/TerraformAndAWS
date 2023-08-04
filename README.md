## TerraformAndAWS


### In this mini project I learn the basic concept of terraform for connecting and provisioning AWS ec2 resource Visual Studio Code. some of the task include:

> 1. Setup AWS IAM user for the project
> 2. Intall Terraform on my local Machine
> 3. Local Environment Setup (Intall AWS toolkit for vscode and connect to the aws with the user created)
> 4. Use terraform AWS Provider to initialise terraform with = Terraform Init
> 5. Use terraform aws resources to create VPC using terraform plan and terraform apply
> 6. Get to understand terraform state and terraform destroy.
> 7. Also use terraform aws resources to create Subnet and Referencing, internet gateway, route table, route table association, security group. I use terraform fmt to format the .tf files properly.
> 8. create an AMI Datasource file and update it with aws ami name.
9> . create a key pair to connect to aws ec2 instance
> 10. create a Userdata and the File Function (copied from online)
> 11. install ssh on my system, create and ssh file to help me connect remotely to the server.
> 12. I also learn Provisioner and Templatefile

<!-- userdata script -->
#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ubuntu
