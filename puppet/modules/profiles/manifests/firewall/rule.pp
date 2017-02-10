define profiles::firewall::rule (
  $proto = 'all',
  $action = 'drop',
  $dport  = undef,
  $sport  = undef,
) {

  firewall { $title:
    proto => $proto,
    action => $action,
    dport  => $dport,
    sport  => $sport,
  }
}
