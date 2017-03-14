class profiles::postgresql (
  $databases               = {},
  $encoding                = 'UTF-8',
  $ip_mask_allow_all_users = '127.0.0.1/32',
  $listen_addresses        = 'localhost',
  $manage_package_repo     = false,
  $version                 = '9.2',
) {

  class { '::postgresql::globals':
    encoding            => $encoding,
    manage_package_repo => $manage_package_repo,
    version             => $version,
  } ->

  class { '::postgresql::server':
    ip_mask_allow_all_users => $ip_mask_allow_all_users,
    listen_addresses        => $listen_addresses,
  }
  create_resources( 'postgresql::server::db', $databases)

  class { '::postgresql::client': }
}

  
