# Terraform Project A

This repository contains Terraform code to set up an AWS infrastructure including EC2 instances, security groups, and an Application Load Balancer (ALB).

## Project Structure

- `main.tf`: The main configuration file that defines the primary infrastructure.
- `ec2-instance.tf`: Configuration for creating EC2 instances.
- `security-group.tf`: Configuration for defining security groups.
- `alb.tf`: Configuration for setting up an Application Load Balancer.
- `ssh-keys.tf`: Manages SSH keys for accessing the instances.
- `variables.tf`: Contains all the input variables used across the configuration files.
- `outputs.tf`: Defines the outputs of the infrastructure deployment.
- `versions.tf`: Specifies the required Terraform version and provider details.

## Infrastructure Overview

The Terraform configuration will create the following AWS resources:

1. **EC2 Instances**: Virtual servers to run applications.
   - **Web Server Instances**: Hosts the web application.
   - **Database Server Instances**: Hosts the database for the web application.
2. **Security Groups**: Firewall rules to control traffic to the EC2 instances.
3. **Application Load Balancer (ALB)**: Distributes incoming application traffic across multiple EC2 instances to ensure high availability.
4. **SSH Key Pairs**: For secure access to the EC2 instances.
5. **Bastion Host**: An instance to securely SSH into the Web and Database servers.

### High-Level Architecture

1. **User Requests**: Users send requests to the Application Load Balancer (ALB).
2. **Load Balancer (ALB)**: The ALB distributes incoming traffic across the **Web Server Instances** to ensure high availability and reliability.
3. **Web Server Instances**: These instances handle the user requests and interact with the **Database Server Instances** to fetch or store data.
4. **Database Server Instances**: These instances store and manage the application's data.
5. **Bastion Host**: A secure host that can SSH into both the Web Server and Database Server instances for maintenance and management purposes.

## Usage

1. **Install Terraform**: Ensure that you have Terraform installed on your local machine. You can download it from [here](https://www.terraform.io/downloads.html).

2. **Clone the Repository**:
    ```sh
    git clone https://github.com/aditya-verp/terraform_project_a.git
    cd terraform_project_a
    ```

3. **Initialize Terraform**: Initialize the Terraform configuration to download the necessary provider plugins.
    ```sh
    terraform init
    ```

4. **Plan the Deployment**: Review the infrastructure changes Terraform will make.
    ```sh
    terraform plan
    ```

5. **Apply the Configuration**: Apply the configuration to create the infrastructure.
    ```sh
    terraform apply
    ```
### NOTE: To Generate the bastion host private key RUN --> terraform output -raw bastion_private_key > bastion_key.pem 
## Variables

You can customize the deployment by modifying the variables in `variables.tf`.

## Outputs

After deployment, you can view the outputs defined in `outputs.tf` using:
```sh
terraform output
