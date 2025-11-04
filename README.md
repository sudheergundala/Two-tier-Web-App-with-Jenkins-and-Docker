# Project Documentation : Automating the Deployment of a Two-Tier Containerized Flask Application on AWS

**Date:** 11/03/2025

------
## Table of contents
1. [Project Overview](#project-overview)
2. [Architecture Diagram](#architecture-diagram)
3. [Step 1: Dockerfile](#dockerfile)
4. [Step 2: Launch an AWS EC2 Instance](#launch-an-AWS-ec2-instance)
5. [Step 3: Install the Dependencies](#install-the-dependencies)
6. [Step 4: Configure the Jenkins with GitHub](#configure-the-jenkins-with-github)
7. [Step 5: Jenkins pipeline Creation and Execution](#jenkins-pipeline-creation-and-execution)
8. [Conclusion](#conclusion)


## 1. Project Overview
This project demonstrates the automation of deployment for a two-tier web application (Flask + MySQL) on an AWS EC2 instance.
The application is containerized using Docker and managed with Docker Compose.
A Jenkins CI/CD pipeline automates the build, test, and deployment process.
Whenever new code is pushed to the GitHub repository, a webhook triggers Jenkins, which rebuilds and redeploys the updated containers automatically.

      # Tools Used:-
          Version Control System - GitHub
          CI/CD - Jenkins
          Container - Docker, Docker Compose
          Cloud - AWS
 