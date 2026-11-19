# StartTech Application

## Overview
A full-stack application deployed using AWS cloud infrastructure and GitHub Actions.

## Technology Stack
- Frontend: React, TypeScript and Vite
- Backend: Golang
- Database: MongoDB Atlas
- Cache: Amazon ElastiCache Redis
- Containers: Docker
- Orchestration: Amazon EKS
- CI/CD: GitHub Actions

## Repository Structure
- frontend/ - React application
- backend/ - Golang REST API
- k8s/ - Kubernetes manifests
- scripts/ - Deployment and rollback scripts
- .github/workflows/ - CI/CD workflows

## Frontend Build
cd frontend
npm ci
npm run build

The production build is generated in frontend/dist.

## Backend Tests
cd backend
go test ./...

## Backend Container
docker build -t starttech-backend-api ./backend

## Kubernetes Deployment
The backend runs on port 8080.

Kubernetes manifests define:
- Backend Deployment
- ClusterIP Service
- Application Load Balancer Ingress

## Health Checks
- /api/v1/health
- /ping

## Configuration
The backend uses environment variables for MongoDB, Redis, JWT authentication, and application settings.

The k8s/backend-config.example.yaml file provides placeholder configuration values only.

Real credentials must be supplied securely and must not be committed to Git.

## CI/CD
Frontend workflow builds and prepares deployment to S3 and CloudFront.

Backend workflow tests Go code, builds and scans a Docker image, and supports deployment to ECR and EKS.

AWS deployment steps currently require manual workflow execution.

## Status
Local backend health check passed. Cloud deployment and end-to-end verification pending.
