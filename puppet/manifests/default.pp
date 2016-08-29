hiera_include('classes')

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

Package {
  allow_virtual => true,
}

firewall { '100 allow http and https access to neo4j':
  dport  => [7473, 7474],
  proto  => tcp,
  action => accept,
}
