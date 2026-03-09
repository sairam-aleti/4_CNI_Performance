# Makefile
# Group 4: CNI Performance Benchmark Infrastructure Automation

CLUSTER_NAME=cni-perf-group-4

cluster:
	kind create cluster --name $(CLUSTER_NAME) --config 4_kind-config.yaml

delete:
	kind delete cluster --name $(CLUSTER_NAME)

clean: delete