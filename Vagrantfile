# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

    config.vm.box = "ubuntu/xenial64"
    config.vm.provision "file", source: "configs/dhcpd.conf", destination: "/tmp/dhcpd.conf"
    config.vm.provision "file", source: "run.sh", destination: "/tmp/run.sh"
    config.vm.provision :shell, path: "setup.sh"

    config.vm.network "private_network", ip: "10.0.0.2",
        virtualbox__intnet: true
    config.vm.provider "virtualbox" do |vb|
        #   # Display the VirtualBox GUI when booting the machine
        #   vb.gui = true
        #
        #   # Customize the amount of memory on the VM:
        vb.memory = "4096"
    end

end
