# XDP Environment setup script
while [ "$EUID" -ne 0 ]; do
echo "Must run as root. Exiting..."
exit 1
done
echo "Installing Compilers..."
apt install -y llvm clang gcc gcc-multilib make
echo "Installing XDP tools..."
apt install -y libbpfcc libelf++0 libelf-dev bpfcc-tools pkg-config libpcap-dev build-essential m4
echo "Installing linux tools..."
sudo apt install -y linux-tools-$(uname -r) linux-tools-common linux-tools-generic
git submodule init && git submodule update
cd Dependencies/libbpf/src/
echo "Installing libbpf..."
make
echo "Installing libbpf headers..."
make install_headers
cd ../../xdp-tools/
./configure
echo "Installing XDP-tools..."
make
echo "Installation completed!"