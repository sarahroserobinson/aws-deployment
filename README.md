# Infrastructure Deployment with CI/CD

## by AWSome Architechs 

## Contents
1. [Overview](#overview)
2. [Technologies](#technologies)
3. [Components Deployed](#components-deployed)
4. [Directories and File Structure](#directories-and-file-structure) 
5. [Usage](#usage)
6. [Troubleshooting](#troubleshooting)

## Overview

This group project builds and manages a cloud-based infrastructure for a learner management system. DevOps practices were continuously integrated into the creation of this project to enhance the scalability and efficiency of the infrastructure and all for continual adaption. 

* Infrastructure as Code (IaC): Creating the infrastructure with Terraform allowed for the automation of the infrastructure setup
* CI/CD Pipeline: The use of CircleCI and ArgoCD created a seamless, automated pipeline for continuous integration and delivery, streamlining the development process.


#### Feedback 
* Monitoring and Alerting: Implemented Prometheus and Grafana for comprehensive monitoring, facilitating real-time feedback on system performance and health.
* Logging: Utilised AWS CloudWatch for detailed logging, offering crucial insights and feedback on the application's operational aspects.


#### Continual Learning
* Exploring Technologies: Our project involved using Docker and Kubernetes for container orchestration and EKS for managing Kubernetes on AWS, along with Helm charts for streamlined Kubernetes management. We explored CircleCI for Continuous Integration, and Argo CD for Continuous Deployment. Furthermore, we experiemented with alternative technologies like Jenkins, a renowned automation server, to compare its CI capabilities with those of CircleCI. We also delved into Pulumi, an infrastructure as code tool that uses familiar programming languages, to understand its advantages and contrasts with Terraform. 


## Technologies
* AWS
* Terraform
* CircleCI
* Argo CD
* Prometheus
* Grafana


## Components Deployed 

Below is an overview of the key components this infrastructure deploys:

* Virtual Private Cloud (VPC): Established a secure and isolated network environment within AWS.
* Security Groups: Configured to manage and control inbound and outbound traffic for enhanced security.
* NAT and Internet Gateways: Facilitated secure and efficient internet connectivity for our network.
* RDS (Relational Database Service): Set up a managed database service for efficient data storage and retrieval.
* EKS (Elastic Kubernetes Service): Created a managed Kubernetes service for deploying and scaling our containerized applications.

## Directories and File Structure

Our project's infrastructure is structured into several modules, each responsible for creating specific components:

* Networking Module: Creates the VPC, defining public and private subnets and setting up the necessary networking components for the project, such as a NAT gateway and internet gateway. It also configures the availability zones for high availability.

* EKS Module: Establishes the Elastic Kubernetes Service, which includes setting up the EKS cluster with auto-scaling capabilities and integrating it with the defined subnets and security groups.

* Security Module: Responsible for creating security groups that dictate the traffic flow to and from the services running in our VPC, ensuring a secure network environment.

* Database Module: Sets up the AWS RDS instance.

Each module's directory contains Terraform files (main.tf, variables.tf, outputs.tf, etc.) that define and configure the respective resources, ensuring modularity and ease of maintenance in our infrastructure setup.

#### Kubernetes Deployment Directory 
* Backend Deployment: Defines the state of the backend application pods. It specifies the Docker image to be used, the number of replicas, and the container port (8080) for the application. Configures the backend service, exposing it through a LoadBalancer. It integrates with Prometheus for monitoring, specifying the metrics port and enabling scraping.
* Frontend Deployment:  Sets up the frontend application pods, detailing the image to be used, the desired number of replicas, and the container port (80). Defines the service for the frontend, making it accessible via a LoadBalancer. It listens on port 3008 and directs traffic to the container's port 80.
* Service Monitor: Used for monitoring the backend service with Prometheus. It specifies the scraping interval, timeout, and the metrics path (/actuator/prometheus) for Prometheus to collect metrics.

## Usage 

### Continuous Integration
The [frontend](https://github.com/ggrady00/ce-team-project-frontend) and [backend](https://github.com/ggrady00/ce-team-project-backend) repo are all setup for usage with CircleCI and will build and push an image to AWS-ECR.
In the build-image-and-push job the repo and public registry alias need to be changed in order to push to your own ECR repo.
#### **Changes needed when building images:**
#### **Frontend:**
- See the .env file.
- VITE_API_BASE_URL=backend-endpoint:8080
- Make sure to replace ‘backend-endpoint’ with the Backend Loadbalancer DNS.
#### **Backend:**
- db/migration - application.yml
- This yml file is setup to migrate the backend database to an RDS postgres instance.
- Change the datasource url to your own RDS endpoint, port and database name.

### Continuous Deployment

We used ArgoCD to connect the projects repo and perform automatic synchronisation based on commits made to the repo. 
In the Argo CD dashboard, connect the repo and create an application, specifying the path where the Kubernetes deployment files are located, the cluster to deploy to, and the namespace within the cluster.
Once the application is set up in Argo CD, it will automatically sync and deploy your application based using the configurations in the deployment files. For any changes made in the deployment files or Kubernetes configurations, simply commit and push these changes to your repository and Argo CD will continuously monitor the repository for any changes and apply them. You can visualize the health and status of your application and manually sync changes if needed.

#### Trouble Shooting

* Check nodes for pod utilisation, each node can hold 11 pods and if this maximum is reached you will need to configure additional pods in either the AWS management console or the Terraform code. If you are editing the Terraform code, you will need to delete your tf.state file and re-apply Terraform after configuring your maximum and desired node sizes. This is due to a bug with Terraform, where the desired size cannot be edited after a Terraform apply command has been used. This will not be solved by destroying and re-applying the terraform code, as the tf.state file will point to the original chosen desired node size.
* Ensure RDS database is configured with the username "postgres", changes to this username can result in unexpected behaviour in PgAdmin.
