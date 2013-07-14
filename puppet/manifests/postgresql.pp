class { 'postgresql':
  charset => 'UTF8',
  locale => 'en_US.UTF-8',
  manage_package_repo => true,
  version => '9.2',

  pg_user { 'vagrant':
    ensure => present,
    superuser => true,
    password => '',
    require => Class['postgresql::server']
  },

  package { 'libpq-dev':
    ensure => installed
  }
}
