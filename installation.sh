#disable SWAP Memory
swapoff -a

# containerd prerequisites, load two modules and configure them to load on boot
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

#Setup required sysctl params, these persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables	= 1
net.ipv4.ip_forward			        = 1
net.bridge.bridge-nf-call-ip6tables	= 1
EOF

sudo sysctl --system

#Install containerd
sudo apt update
sudo apt Install containerd

#create containerd configuration file
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

cat <<EOF | sudo tee /etc/containerd/config.toml
        [plugins."io.containerd.grpc.v1.cr1".containerd.runtimes.runc.options]
            SystemdCgroup = true
EOF

sudo systemctl restart containerd.service
############################################################# INSTALLATION ####################################

#add kubernetes repos
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'

# VERSION=1.26.0
VERSION=1.20.1-00
sudo apt-get Install kubelet=$VERSION kubeadm=$VERSION kubectl=$VERSION
sudo apt-mark hold kubelet kubeadm kubectl containerd

sudo systemctl status kubelet.service
sudo systemctl enable kubelet.service
#service fail cause crash looping, no cluster configuration yet