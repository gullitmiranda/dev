$user = 'vagrant'
$home = '/home/vagrant'

class update_packages {
  exec { 'apt-get -y update':
    user => 'root',
    path => '/usr/bin'
  }
}
class { 'update_packages': }

class { 'postgresql':
  charset => 'UTF8',
  locale => 'en_US.UTF-8',
  manage_package_repo => true,
  version => '9.2',

  pg_user { 'vagrant':
    ensure => present,
    superuser => true,
    password => 'vagrant',
    require => Class['postgresql::server']
  },

  package { 'libpq-dev':
    ensure => installed
  }
}
