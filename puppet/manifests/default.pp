hiera_include('classes')

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

Package {
  allow_virtual => true,
}

class pre {
  Firewall {
    require  => undef,
  }

  firewall { '0000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  } ->

  firewall { '0001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  } ->
  
  firewall { '0002 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
}

class post {

  firewall { '9998 log packet drops':
    jump       => 'LOG',
    proto      => 'all',
    log_prefix => 'iptables InDrop: ',
    log_level  => 'warn',
  } ->
  
  firewall { '9999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef
  }
}

class { ['pre', 'post']: } ->
resources { 'firewall':
  purge => true
}

Firewall {
  require => Class['pre'],
  before  => Class['post'],
}

firewall { '22 - ssh':
  proto  => 'tcp',
  dport  => '22',
  action => 'accept'
}

firewall { '7474 - neo4j':
  proto  => 'tcp',
  dport  => '7474',
  action => 'accept'
}

notify { $::java_version: }
