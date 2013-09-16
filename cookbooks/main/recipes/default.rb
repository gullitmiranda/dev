include_recipe 'apt'
include_recipe 'openssl'
include_recipe 'set_locale'

# Ensure locales
ENV['LANGUAGE'] = ENV['LANG'] = ENV['LC_ALL'] = 'en_US.UTF-8'

# Postgres configuration
node.set['postgresql']['password']['postgres'] = 'password'
node.set['postgresql']['pg_hba'] = [
  {
    :type => 'local',
    :db => 'all',
    :user => 'postgres',
    :method => 'trust'
  }
]

include_recipe 'postgresql::server'

# Packages
%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev sphinxsearch
).each do |package_name|
  package package_name do
    action :install
  end
end
