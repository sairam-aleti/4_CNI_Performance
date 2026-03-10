CLUSTER_NAME=cni-perf-group-4

cluster:
	kind create cluster --name $(CLUSTER_NAME) --config 4_kind-config.yaml

delete:
	kind delete cluster --name $(CLUSTER_NAME)

flannel:
	kubectl apply -f 4_flannel.yaml

workload:
	kubectl apply -f 4_workload.yaml

clean: delete