
# AWS Infrastructure with Terraform

This repository contains Terraform scripts to provision and manage AWS infrastructure. The project is designed to automate infrastructure deployment and management using Infrastructure as Code (IaC) principles. 

## Features

- **Provisioning AWS Resources**: EC2 instances, VPCs, subnets, security groups, and more.
- **Modular Terraform Code**: Makes the infrastructure easily reusable and maintainable.
- **Automated Deployments**: Streamlined provisioning of infrastructure with minimal manual intervention.

## Prerequisites

- **Terraform**: Ensure Terraform is installed (v0.14+).
- **AWS CLI**: Install and configure AWS CLI with valid credentials.
- **AWS Account**: Required for provisioning AWS infrastructure.
- **IAM Role**: Ensure proper permissions for Terraform to provision resources on AWS.

## Project Structure

```bash
/
├── /modules                                # Contains reusable Terraform modules
│   ├── /network                            # Module for VPC, subnets, and gateways
│   └── /compute                            # Module for EC2 instances
├── /environments
│   ├── /dev                                # Terraform code for the development environment
│   └── /prod                               # Terraform code for the production environment
├── /scripts                                # Shell scripts for automation
├── /main.tf                                # Main entry Terraform script
├── /variables.tf                           # Input variables
├── /outputs.tf                             # Output variables
├── /provider.tf                            # AWS provider configuration
└── /README.md                              # Project README (this file)
```

## Installation and Setup

### 1. Clone the Repository

```bash
git clone https://github.com/vishnuswmech/aws_infra.git
cd aws_infra
```

### 2. Configure AWS CLI

Ensure the AWS CLI is installed and configured. Run the following command to configure your credentials:

```bash
aws configure
```

Provide your AWS Access Key, Secret Access Key, region, and default output format.

### 3. Initialize Terraform

Navigate to the desired environment (`dev` or `prod`) and initialize Terraform:

```bash
cd environments/dev    # or cd environments/prod
terraform init
```

### 4. Apply the Terraform Configuration

To provision the infrastructure, run the following Terraform command:

```bash
terraform apply
```

Terraform will prompt you for confirmation. Type `yes` to proceed.

### 5. Destroying the Infrastructure

If you wish to tear down the infrastructure, you can run:

```bash
terraform destroy
```

This will remove all the resources created by Terraform.

## Modular Design

This project follows a modular approach to Terraform, where resources like networking (VPCs, subnets) and compute (EC2 instances) are defined in separate reusable modules. This design makes it easy to extend or modify the infrastructure as required.

### Network Module

Located in `/modules/network`, this module handles the creation of:

- VPC
- Subnets
- Internet Gateways
- Route Tables

### Compute Module

Located in `/modules/compute`, this module provisions:

- EC2 instances
- Security Groups

## Variables

Input variables for each environment are defined in `variables.tf`. You can modify the default values or pass new values when applying the configuration.

```bash
# Example of passing a variable during apply
terraform apply -var="instance_type=t2.micro"
```

## Outputs

Output values such as EC2 instance IDs, VPC IDs, and other resource identifiers are defined in `outputs.tf` and can be used for further integrations.

## Automation Scripts

The `/scripts` folder contains automation scripts that can be used for:

- Setting up additional dependencies
- Post-deployment configurations
- Integration with other services
