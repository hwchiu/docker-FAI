# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

    config.vm.box = "ubuntu/xenial64"
    config.vm.provision "file", source: "configs/tftp", destination: "/tmp/tftp"
    config.vm.provision "file", source: "configs/dhcpd.conf", destination: "/tmp/dhcpd.conf"
    config.vm.provision "file", source: "configs/isc-dhcp-server", destination: "/tmp/isc-dhcp-server"
    config.vm.provision "file", source: "syslinux/pxelinux.0", destination: "/tmp/pxelinux.0"
    config.vm.provision "file", source: "syslinux/libcom32.c32", destination: "/tmp/libcom32.c32"
    config.vm.provision "file", source: "syslinux/libutil.c32", destination: "/tmp/libutil.c32"
    config.vm.provision "file", source: "syslinux/ldlinux.c32", destination: "/tmp/ldlinux.c32"
    config.vm.provision "file", source: "syslinux/vesamenu.c32", destination: "/tmp/vesamenu.c32"
    config.vm.provision "file", source: "syslinux/default", destination: "/tmp/default"
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
