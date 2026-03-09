# Makefile
# Group 4: CNI Performance Benchmark Infrastructure Automation

CLUSTER_NAME := cni-benchmark
KIND_CONFIG := 4_kind-config.yaml

.PHONY: create-cluster delete-cluster

create-cluster:
	@echo "Bootstrapping Kubernetes cluster: $(CLUSTER_NAME)..."
	kind create cluster --name $(CLUSTER_NAME) --config $(KIND_CONFIG)
	@echo "Cluster created! Nodes will show as 'NotReady' until CNI is installed."
	kubectl get nodes

delete-cluster:
	@echo "Destroying Kubernetes cluster: $(CLUSTER_NAME)..."
	kind delete cluster --name $(CLUSTER_NAME)
	@echo "Cluster completely removed."