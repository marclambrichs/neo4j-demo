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
  Firewall {
    before => undef
  }

  firewall { '9998 log packet drops':
    jump       => 'LOG',
    proto      => 'all',
    log_prefix => 'iptables InDrop: ',
    log_level  => 'warn',
  } ->
  
  firewall { '9999 drop all':
    proto  => 'all',
    action => 'drop',
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

firewall { '123 - ntp':
  proto  => 'udp',
  dport  => '123',
  action => 'accept'
}

firewall { '7473 - neo4j':
  proto  => 'tcp',
  dport  => [7473, 7474, 9000],
  action => 'accept'
}

firewall { '5000 - neo4j discovery':
  proto  => 'tcp',
  dport  => 5000,
  source => '10.10.10.0/24',
  action => 'accept'
}
firewall { '6000 - neo4j tx':
  proto  => 'tcp',
  dport  => 6000,
  source => '10.10.10.0/24',
  action => 'accept'
}
firewall { '7000 - neo4j raft':
  proto  => 'tcp',
  dport  => 7000,
  source => '10.10.10.0/24',
  action => 'accept'
}  

node 'neo4j' {
}

node 'core1.causal.vagrant' {
}

node 'core2.causal.vagrant' {
}

node 'core3.causal.vagrant' {
}
