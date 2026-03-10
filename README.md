# Kubernetes CNI Performance Evaluation

## Project Overview
This project aims to experimentally evaluate the networking performance of different Container Network Interface (CNI) plugins in Kubernetes. The goal is to understand how various networking solutions affect communication between containerized applications.

The project sets up a Kubernetes-based experimental environment and deploys simple containerized services to measure networking metrics such as latency and throughput.

---

## What we built for Milestone 1
Instead of manually typing setup commands, we automated the infrastructure so any team member can reproduce the exact same testing environment:
* **The Cluster:** We are running a 3-node Kubernetes cluster using `kind` (1 control-plane, 2 workers). We explicitly disabled the default kindnet network so we could inject our own CNIs.
* **The Network:** We deployed Flannel (VXLAN) as our baseline CNI.
* **The Workload:** We are using `iperf3` client and server pods pinned to separate worker nodes to blast traffic across the Flannel network.
* **Profiling:** We wrote a bash script (`4_profile.sh`) that triggers the Linux `perf stat` tool and `docker stats` during the iperf3 test. This captures kernel-level CPU cycles, user-space overhead, and memory usage.
* **Plotting:** A Python script (`4_plot.py`) uses matplotlib to graph the throughput and CPU overhead data.

## How to run it
We set up a Makefile to make this painless. If you have Docker and Kind installed, just run:
1. `make cluster` - Boots the empty 3-node cluster.
2. `make flannel` - Installs the Flannel CNI.
3. `make workload` - Spins up the iperf3 client and server.
4. `make profile` - Runs the network benchmark and logs the CPU data.
5. `make plot` - Generates the bar charts from the profiling data.
6. `make clean` - Deletes the cluster and wipes the log files to free up your RAM.