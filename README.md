# Kubernetes Troubleshooting Image

A lightweight Docker image based on Alpine Linux designed for troubleshooting issues on Kubernetes nodes.

## Contents

This image contains essential tools for Kubernetes node troubleshooting:

### Core Requirements

| Package | Description | Purpose |
|---------|-------------|---------|
| **procps** | Process utilities | Monitoring running processes on K8s nodes |
| **sysstat** | System performance tools | Collecting system performance metrics |
| **vim/vi** | Text editor | Viewing and editing config files and logs |
| **python3** | Programming language | Running diagnostic scripts |
| **curl** | Data transfer tool | Testing HTTP connectivity and APIs |
| **wget** | File retrieval utility | Downloading files and testing connectivity |
| **bash** | Shell | Advanced command execution environment |

### Additional Diagnostic Tools

| Tool | Description | Purpose |
|------|-------------|---------|
| **net-tools** | Network utilities | Network configuration (ifconfig, route) |
| **iputils** | IP utilities | Network reachability testing (ping) |
| **bind-tools** | DNS utilities | DNS troubleshooting (dig, nslookup) |
| **tcpdump** | Packet analyzer | Capturing and analyzing network traffic |
| **strace** | System call tracer | Diagnosing process-related issues |
| **ltrace** | Library call tracer | Tracking dynamic library calls |
| **lsof** | List open files | Finding which processes have files open |
| **htop** | Process viewer | Monitoring system resource usage |

## Usage

### Build the Image

```bash
# Standard build
docker build -t k8s-troubleshooter:latest .

# For specific architecture
docker build --platform linux/amd64 -t k8s-troubleshooter:latest .
```

### Push to Docker Registry

```bash
# Set variables
export DOCKER_REGISTRY="your-registry-url:port"
export DOCKER_IMAGE_PATH="repository/k8s-troubleshooter"
export VERSION="latest"
export CI_REGISTRY_USER="your-username"
export CI_REGISTRY_PASSWORD="your-password"

# Login, build and push
docker login ${DOCKER_REGISTRY} -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD}
docker build --platform linux/amd64 -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE_PATH}:${VERSION} .
docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_PATH}:${VERSION}
```

### Use in Kubernetes

```bash
# Debug a node
kubectl debug node/your-node-name -it --image=your-registry/k8s-troubleshooter:latest

# Create a troubleshooting pod
kubectl run troubleshooter --image=your-registry/k8s-troubleshooter:latest -it -- bash
```

## Common Troubleshooting Commands

### Network Diagnostics
```bash
# DNS resolution
dig kubernetes.default.svc.cluster.local

# Connect to a service
curl -v http://service-name.namespace:port

# Packet capture
tcpdump -i any host pod-ip
```

### System Performance
```bash
# Process monitoring
top
htop

# I/O statistics
iostat -x 1

# CPU statistics
mpstat -P ALL 1
```

### Log Analysis
```bash
# View container logs
vi /var/log/containers/pod-name_namespace_container-id.log

# Find open files
lsof | grep <path>
```

## Maintenance

Periodically update the image to include:
- Latest Alpine base image (security updates)
- Updated troubleshooting tools
- New diagnostic utilities as Kubernetes evolves