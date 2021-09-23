Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|
  config.vm.synced_folder ".", "/home/vagrant/dotfiles"
  config.vm.synced_folder "~/Developer", "/home/vagrant/Developer"
  config.vm.box = "ubuntu/impish64"
  config.vm.network "public_network"
  config.vm.network "forwarded_port", guest: 22, host: 22
  config.vm.provision "shell", inline: <<-SHELL
    apt update
    test -e /usr/bin/python3 || (apt -qqy update && apt install -qqy python-minimal)
    apt -qqy install python3-pip
    pip3 install ansible
  SHELL
end
