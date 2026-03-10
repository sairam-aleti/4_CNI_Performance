import matplotlib.pyplot as plt
import numpy as np



CNI_TYPES = ['Flannel (VXLAN)']
THROUGHPUT_MBPS = [8820.0] 
CPU_OVERHEAD_KERNEL = [75.0] 
CPU_OVERHEAD_USER = [30.0]    

def plot_performance():
  
    plt.figure(figsize=(10, 5))
    plt.subplot(1, 2, 1)
    plt.bar(CNI_TYPES, THROUGHPUT_MBPS, color='skyblue', edgecolor='darkblue')
    plt.ylabel('Throughput (Mbps)')
    plt.title('CNI Throughput (iperf3)')
    plt.grid(axis='y', linestyle='--', alpha=0.7)

   
    plt.subplot(1, 2, 2)
    p1 = plt.bar(CNI_TYPES, CPU_OVERHEAD_KERNEL, color='salmon', label='Kernel Space')
    p2 = plt.bar(CNI_TYPES, CPU_OVERHEAD_USER, bottom=CPU_OVERHEAD_KERNEL, color='lightgreen', label='User Space')
    plt.ylabel('CPU Utilization (%)')
    plt.title('Kernel vs User CPU Overhead')
    plt.legend()
    plt.grid(axis='y', linestyle='--', alpha=0.7)

    plt.tight_layout()
    plt.savefig('4_cni_performance_plot.png')
    print("Plot generated: 4_cni_performance_plot.png")

if __name__ == "__main__":
    plot_performance()
