# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

    config.vm.box = "ubuntu/xenial64"
    config.vm.provision "file", source: "images/ubuntu-16.04.3-desktop-amd64.iso", destination: "/tmp/ubuntu-16.04.3-desktop-amd64.iso"
    config.vm.provision :shell, path: "setup.sh"
    config.vm.provision "file", source: "config/tftp", destination: "/etc/xinetd.d/tftp"
    config.vm.provision "file", source: "config/dhcpd.conf", destination: "/etc/dhcp/dhcpd.conf"
    config.vm.provision "file", source: "config/isc-dhcp-server", destination: "/etc/default/isc-dhcp-server"

    config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
    virtualbox__intnet: "vboxnet0"
    config.vm.provider "virtualbox" do |vb|
        #   # Display the VirtualBox GUI when booting the machine
        #   vb.gui = true
        #
        #   # Customize the amount of memory on the VM:
        vb.memory = "4096"
    end

end
