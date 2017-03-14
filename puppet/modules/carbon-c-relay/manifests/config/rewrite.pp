#
define carbon_c_relay::config::rewrite (
  $from     = undef,
  $into     = undef,
  $comments = undef,
  $order    = undef,
){

  concat::fragment { "rewrite-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/rewrite.erb'),
    order   => $order
  }
}
