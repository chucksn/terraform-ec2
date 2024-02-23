# Terraform AWS Configuration

This Terraform configuration creates an AWS infrastructure consisting of a Virtual Private Cloud (VPC), an EC2 instance, a key pair, and associated security groups. The VPC is created using the `terraform-aws-modules/vpc/aws` module, and it includes public subnets in multiple availability zones. The EC2 instance is launched in one of these subnets, and security groups are defined to control inbound and outbound traffic.

## Prerequisites

Before applying this Terraform configuration, ensure that you have the following:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- AWS credentials configured with appropriate permissions.
- Terraform cloud configured and enabled to CLI-driven run workflow.

Open the backend.tf file and edit the cloud block within terraform block to your terraform cloud organization and specific workspace.

```hcl
terraform {
  cloud {
    organization = "org-1"

    workspaces {
      name = "workspace-1"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}
```

## Configuration Overview

### 1. VPC Module

The VPC module is sourced from `terraform-aws-modules/vpc/aws` and is used to create a VPC with public subnets in different availability zones.

### 2. Key Pair

A key pair is created for SSH access to the EC2 instance. The public key is read from the local file key.pub.

Add the key.pub file to the root module where it can be read, follow these steps:

1. Navigate to the root directory of your Terraform configuration.
2. Create a file named key.pub and paste your SSH public key into it.
3. Save the file in the root directory of your Terraform configuration.

### 3. Variables

- project_name: The name of the project.
- region-1: The AWS region identifier (e.g., "us-west-2").
- region-2: Alternative AWS region identifier
- ami: The ID of the Amazon Machine Image (AMI) for the EC2 instance.
- instance_type: The type of EC2 instance to launch.

### 4. Outputs

- public_ip : Public ip of the ec2 instance or server provisioned.

### 5. Usage

1. Create a terraform.tfvars file and set the required variables in your terraform.tfvars file.
2. Run terraform init to initialize your working directory.
3. Run terraform apply to apply the configuration and create the infrastructure.
