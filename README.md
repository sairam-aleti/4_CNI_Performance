# Kubernetes CNI Performance Evaluation

## Project Overview
This project aims to experimentally evaluate the networking performance of different Container Network Interface (CNI) plugins in Kubernetes. The goal is to understand how various networking solutions affect communication between containerized applications.

The project sets up a Kubernetes-based experimental environment and deploys simple containerized services to measure networking metrics such as latency and throughput.

---

## Initial Implementation

The initial implementation consists of a minimal containerized HTTP server that runs inside a Kubernetes pod. This service will later be used to test communication between pods and evaluate networking behavior under different CNI configurations.

The server responds with the hostname of the pod, allowing us to verify pod-to-pod communication and service routing.

---

## Project Structure
