class user {
group { 'admin':
  ensure => 'present',
    gid => 501,
  }
  user { 'js':
    ensure => present,
    comment => 'John Smith',
	gid => '501',
    home => '/home/js',
    managehome => true,
	password         => 'testjs',
    password_max_age => '99999',
    password_min_age => '0',
	uid              => '5001',
  }
  user { 'ab':
    ensure => present,
    comment => 'Alpha Beta',
	gid => '501',
    home => '/home/ab',
    managehome => true,
	password         => 'testab',
    password_max_age => '99999',
    password_min_age => '0',
	uid              => '5002',
  }
}