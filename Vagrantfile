Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, path: "build_scripts/bootstrap.sh"
  config.vm.provision :shell, path: "build_scripts/install_wkhtmltopdf.sh"
  config.vm.network :forwarded_port, guest: 5000, host: 5555
end
