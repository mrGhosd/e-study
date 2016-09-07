Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/home/vagrant/estudy', type: 'rsync'
end
