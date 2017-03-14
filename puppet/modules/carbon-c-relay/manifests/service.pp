# == Class carbon_c_relay::service
#
#
class carbon_c_relay::service (
  $config_file      = $carbon_c_relay::config_file,
  $group            = $carbon_c_relay::group,
  $init_file        = $carbon_c_relay::init_file,
  $limit_as         = $carbon_c_relay::limit_as,
  $limit_cpu        = $carbon_c_relay::limit_cpu,
  $limit_fsize      = $carbon_c_relay::limit_fsize,
  $limit_no_file    = $carbon_c_relay::limit_no_file,
  $limit_nproc      = $carbon_c_relay::limit_nproc,
  $log_dir          = $carbon_c_relay::log_dir,
  $service_enable   = $carbon_c_relay::service_enable,
  $service_ensure   = $carbon_c_relay::service_ensure,
  $service_file     = $carbon_c_relay::service_file,
  $service_manage   = $carbon_c_relay::service_manage,
  $service_name     = $carbon_c_relay::service_name,
  $service_template = $carbon_c_relay::service_template,
  $user             = $carbon_c_relay::user,
) {

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {

    file { $log_dir:
      ensure => directory,
      group  => $group,
      mode   => '0644',
      owner  => $user,
    }

    File[$log_dir] ~> Service[$service_name]

    file { $service_file:
      ensure  => file,
      group   => 'root',
      mode    => '0644',
      owner   => 'root',
      content => template($service_template),
    }

    exec { 'daemon-reload':
      command     => '/bin/systemctl daemon-reload',
      subscribe   => File[$carbon_c_relay::service_file],
      refreshonly => true,
      user        => 'root'
    } ~>

    service { $service_name:
      ensure   => $service_ensure,
      enable   => $service_enable,
      provider => 'systemd',
    }
  }
}
