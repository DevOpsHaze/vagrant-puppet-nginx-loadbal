# -*- mode: ruby -*-
# vi: set ft=ruby :
#Installing vagrant cachier plugin helps reduce vagrant up time and whilst saving bandwidth with each iteration
required_plugins = %w( vagrant-cachier)
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

  Vagrant.configure("2") do |config|
  #config.vm.define "config" do |config|
  #config.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"
  #config.vm.box_url= "https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-nocm"
config.vm.define "webapp1" do |webapp1| 
webapp1.vm.box = "puppetlabs/ubuntu-14.04-64-nocm" 
webapp1.vm.network "private_network", ip: "192.168.33.11"
webapp1.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh" 
webapp1.vm.provision :shell do |s| 
s.args = "1", s.path = "provision-webapp.sh" end
end

config.vm.define "webapp2" do |webapp2| 
webapp2.vm.box = "puppetlabs/ubuntu-14.04-64-nocm" 
webapp2.vm.network "private_network", ip: "192.168.33.12"
webapp2.vm.network :forwarded_port, guest: 22, host: 10222, id: "ssh"  
webapp2.vm.provision :shell do |s| 
s.args = "2", s.path = "provision-webapp.sh" end
end

config.vm.define "webserver" do |webserver| 
webserver.vm.box = "puppetlabs/ubuntu-14.04-64-nocm" 
webserver.vm.network "private_network", ip: "192.168.33.10"
webserver.vm.provider "virtualbox" do |v|
	v.memory = 256
  end
  webserver.vm.network :forwarded_port, guest: 80, host: 8080

  #Installing Puppet
  webserver.vm.provision :shell, :inline => "sudo apt-get update && sudo apt-get install puppet -y"

  #download the modules using a vagrant shell command before the puppet provisioner runs.
  webserver.vm.provision :shell, :run => "always" do |shell|
  shell.inline = %{
    mkdir -p /etc/puppet/modules;
    function install_module {
      folder=`echo $1 | sed s/.*-//`
      if [ ! -d /etc/puppet/modules/$folder ]; then
        puppet module install $1 --module_repository https://forge.puppet.com/ 
      fi
    }
    install_module jfryman-nginx
  }
end
  #Provision puppet
	webserver.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "site.pp"
	puppet.module_path = 'puppet/modules'
  end
  #webserver.vm.provision "shell", path: "provision-webserver.sh"
  webserver.vm.provision :shell, :inline => "echo ******* Running NGINX Tests ***********"
  webserver.vm.provision :shell, path: "nginx-test.sh"
  
end
end