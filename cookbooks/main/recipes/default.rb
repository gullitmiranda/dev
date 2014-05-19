include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

# sudo
node.set["authorization"]["sudo"] = {
  :users => ["vagrant"],
  :passwordless => true
}

# Apache
node.set['apache'] = {
  :default_site_enabled => true,
  :log_dir => '/www',
  :docroot_dir => '/www'
}

# Postgres
node['postgresql'][:version] = "9.3"
node['postgresql'][:contrib][:packages] = "postgresql-contrib-9.3"
node['postgresql'][:contrib][:extensions] = ['hstore']
node['postgresql'][:password][:postgres] = 'postgres'
node['postgresql'][:enable_pgdg_apt] = true
node['postgresql'][:pg_hba] = [{:type => 'local',
                                :db => 'all',
                                :user => 'postgres',
                                :method => 'trust'}]

# rvm
node.set['rvm']['installer_url'] = "https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer"
node.set['rvm']['user_installs'] = [ {
  :user => 'vagrant',
  :install_rubies => true,
  :default_ruby => 'ruby-2.1'
} ]
node.set['rvm']['vagrant'] = {
  :system_chef_solo => '/usr/local/bin/chef-solo'
}

# Heroku Toolbelt
node.set['heroku-toolbelt']['standalone'] = false

# Python
node.set["python"]["install_method"] = "package"

include_recipe 'sudo'
include_recipe 'ark'
include_recipe 'build-essential'
include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe 'apache2::mod_rewrite'
include_recipe 'postgresql::server'
include_recipe 'python'
include_recipe 'python::pip'
include_recipe 'python::virtualenv'
include_recipe 'nodejs'
include_recipe 'nodejs::npm'
include_recipe 'heroku-toolbelt'
include_recipe 'phantomjs::default'

# Packages
%w(build-essential curl vim git-core git-flow htop imagemagick).each do |package_name|
  package package_name do
    action :install
  end
end

include_recipe 'rvm::vagrant'
include_recipe 'rvm::user'
