#
define carbon_c_relay::config::cluster (
  $channel            = 'carbon_ch',
  $cluster_name       = $title,
  $file               = undef,
  $hosts              = [],
  $replication_factor = undef
){

  validate_string($cluster_name)

  if ! ($file == undef) {
    validate_string( $file )
  }

  if ! ($channel in ['carbon_ch', 'fnv1a_ch', 'forward', 'file']) {
    fail("channel '${channel}' is not in ['carbon_ch', 'fnv1a_ch', 'forward', 'file']")
  }

  unless is_array( $hosts ) {
    fail("'hosts' param is not a array")
  }

  concat::fragment { "cluster-${title}":
    target  => $carbon_c_relay::config_file,
    content => template('carbon_c_relay/config/cluster.erb'),
    order   => '20',
  }
}
