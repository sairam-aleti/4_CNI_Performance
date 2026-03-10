#!/bin/bash

# Configuration
CLUSTER_NAME="cni-perf-group-4"
SERVER_POD="iperf3-server"
CLIENT_POD="iperf3-client"
DURATION=30

echo "Starting CNI Performance"

echo "Waiting for the pods to ready."
kubectl wait --for=condition=Ready pod/$SERVER_POD --timeout=60s
kubectl wait --for=condition=Ready pod/$CLIENT_POD --timeout=60s

echo "Server Pod IP Resolving."
SERVER_IP=$(kubectl get pod $SERVER_POD -o jsonpath='{.status.podIP}')
echo "Server IP is : $SERVER_IP"

WORKER1_CONTAINER="${CLUSTER_NAME}-worker"
WORKER2_CONTAINER="${CLUSTER_NAME}-worker2"

#Getting PIDs of the Docker containers on host
PID1=$(docker inspect --format '{{.State.Pid}}' $WORKER1_CONTAINER)
PID2=$(docker inspect --format '{{.State.Pid}}' $WORKER2_CONTAINER)

echo "Worker 1(Server Node) PID: $PID1 and Worker 2 (Client Node) PID: $PID2"

# 3. Synchronized iperf3 and perf profiling
echo "Now Running iperf3 test for $DURATION seconds during profiling kernel overhead"

#Handling the permission errors
perf stat -p $PID1,$PID2 sleep $DURATION > 4_perf_results.log 2>&1 &
PERF_PID=$!

#To capture total CPU/MEM footprint, run docker stats in background 
(
    echo "Time,Container,CPU%,Mem%"
    for i in $(seq 1 $DURATION); do
        docker stats --no-stream --format "{{.Name}},{{.CPUPerc}},{{.MemPerc}}" $WORKER1_CONTAINER $WORKER2_CONTAINER
        sleep 1
    done
) > 4_docker_stats.log & 
STATS_PID=$!

kubectl exec $CLIENT_POD -- iperf3 -c $SERVER_IP -t $DURATION > 4_iperf_results.log

wait $PERF_PID 2>/dev/null ||true
wait $STATS_PID 2>/dev/null||true


echo "Benchmark Complete."
echo "Iperf3 Throughput results are saved to 4_iperf_results.log"
echo "The results of Kernal profiling are saved to 4_perf_results.log"


THROUGHPUT=$(grep "receiver" 4_iperf_results.log | awk '{print $7, $8}')
echo "Measured Throughput is: $THROUGHPUT"
grep -E "cycles|instructions" 4_perf_results.log
