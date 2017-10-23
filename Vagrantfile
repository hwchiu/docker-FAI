# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

    config.vm.box = "ubuntu/xenial64"

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
