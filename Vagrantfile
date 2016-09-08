require 'chef'
require 'json'

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/home/vagrant/estudy', type: 'rsync'

  def path_for_chef_folder(folder)
    Pathname(__FILE__).dirname.join('chef', 'nodes', folder)
  end
  
  Chef::Config.from_file(File.join(File.dirname(__FILE__), 'chef', '.chef', 'knife.rb'))
  vagrant_json = JSON.parse(Pathname(__FILE__).dirname.join('chef', 'nodes', (ENV['NODE'] || 'vagrant.json')).read)

  config.vm.provision :chef_solo do |chef|
     chef.cookbooks_path = Chef::Config[:cookbook_path]
     chef.roles_path = Chef::Config[:role_path]
     chef.data_bags_path = Chef::Config[:data_bag_path]
     chef.environments_path = Chef::Config[:environment_path]
     #chef.environment = ENV[’ENVIRONMENT’] || ’development’
     chef.run_list = vagrant_json.delete('run_list')
     chef.json = vagrant_json
  end
end
