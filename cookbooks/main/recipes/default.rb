include_recipe 'apt'
include_recipe 'openssl'

# Postgres configuration
node.set['postgresql']['password']['postgres'] = 'password'
node.set['postgresql']['pg_hba'] = [
  {
    type: 'local',
    db: 'all',
    user: 'postgres',
    method: 'trust'
  }
]

# rbenv configuration
node.default['rbenv']['user_installs'] = [ { 'user' => 'vagrant' } ]

include_recipe 'postgresql::server'
include_recipe 'rbenv::user_install'
include_recipe 'ruby_build'

# Packages
%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev vim tmux memcached
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev sphinxsearch
).each do |package_name|
  package package_name do
    action :install
  end
end

require_relative 'dotfiles'

