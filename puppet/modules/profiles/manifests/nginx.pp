class profiles::nginx (
  $daemon_user    = 'nginx',
  $upstreams      = {},
  $vhosts         = {},
  $vhost_packages = {},
) {

  class { 'nginx':
    daemon_user => $daemon_user,
  }

  $package_defaults = {
    ensure => present,
    tag    => 'do_a',
  }
  create_resources( 'package', $vhost_packages, $package_defaults )

  $resource_defaults = {
    tag => 'do_b',
  }

  create_resources( 'nginx::resource::server', $vhosts, $resource_defaults )  

  create_resources( 'nginx::resource::upstream', $upstreams, $resource_defaults )

  Package<| tag == 'do_a' |> -> Nginx::Resource::Server<| tag == 'do_b' |>
  Package<| tag == 'do_a' |> -> Nginx::Resource::Upstream<| tag == 'do_b' |>

}
