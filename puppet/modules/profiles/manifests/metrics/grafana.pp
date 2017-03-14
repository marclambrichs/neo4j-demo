# == Class profiles::metrics::grafana
#
# == Parameters
#
# @param archive_source
# @param cfg_auth_anonymous_enabled
# @param cfg_auth_anonymous_org_name
# @param cfg_auth_anonymous_org_role
# @param cfg_auth_basic_enabled
# @param cfg_auth_proxy_auto_sign_up
# @param cfg_auth_proxy_enabled
# @param cfg_auth_proxy_header_name
# @param cfg_auth_proxy_header_property
# @param cfg_dashboards_json_enabled
# @param cfg_dashboards_json_path
# @param cfg_database_host
# @param cfg_database_name
# @param cfg_database_password
# @param cfg_database_path
# @param cfg_database_type
# @param cfg_database_user
# @param cfg_event_publisher_enabled
# @param cfg_event_publisher_exchange
# @param cfg_event_publisher_rabbitmq_url
# @param cfg_location
# @param cfg_log_buffer_length
# @param cfg_log_console_level
# @param cfg_log_file_daily_rotate
# @param cfg_log_file_log_rotate
# @param cfg_log_file_max_days
# @param cfg_log_file_max_lines
# @param cfg_log_file_max_lines_shift
# @param cfg_log_level
# @param cfg_log_mode
# @param cfg_security_admin_password
# @param cfg_security_admin_user
# @param cfg_security_cookie_remember_name
# @param cfg_security_cookie_username
# @param cfg_security_data_source_proxy_whitelist
# @param cfg_security_disable_gravatar
# @param cfg_security_login_remember_days
# @param cfg_security_secret_key
# @param cfg_server_http_addr
# @param cfg_server_protocol
# @param cfg_users_allow_org_create
# @param cfg_users_allow_sign_up
# @param cfg_users_auth_assign_org_role
# @param cfg_users_auto_assign_org
# @param container_cfg
# @param container_params
# @param data_dir
# @param datasources
# @param install_dir
# @param install_method
# @param ldap_cfg
# @param manage_package_repo
# @param package_name
# @param package_source
# @param repo_name
# @param rpm_iteration
# @param service_name
# @param version
#
# === Authors
#
# Marc Lambrichs <marc.lambrichs@gmail.com>
#
# === Copyright
#
# Copyright 2016-2017 Marc Lambrichs, unless otherwise noted.
#
class profiles::metrics::grafana (
  $archive_source                           = undef,
  $cfg_auth_anonymous_enabled               = true,
  $cfg_auth_anonymous_org_name              = 'ArthurJames',
  $cfg_auth_anonymous_org_role              = 'Viewer',
  $cfg_auth_basic_enabled                   = true,
  $cfg_auth_proxy_auto_sign_up              = true,
  $cfg_auth_proxy_enabled                   = false,
  $cfg_auth_proxy_header_name               = 'X-WEBAUTH-USER',
  $cfg_auth_proxy_header_property           = 'username',
  $cfg_dashboards_json_enabled              = false,
  $cfg_dashboards_json_path                 = '/var/lib/grafana/dashboards',
  $cfg_database_host                        = '127.0.0.1:5432',
  $cfg_database_name                        = 'grafana',
  $cfg_database_password                    = 'secret',
  $cfg_database_path                        = undef,
  $cfg_database_type                        = 'postgres',
  $cfg_database_user                        = 'grafana',
  $cfg_event_publisher_enabled              = false,
  $cfg_event_publisher_exchange             = 'grafana_events',
  $cfg_event_publisher_rabbitmq_url         = '',
  $cfg_location                             = '/etc/grafana/grafana.ini',
  $cfg_log_buffer_length                    = 10000,
  $cfg_log_console_level                    = '',
  $cfg_log_file_daily_rotate                = true,
  $cfg_log_file_log_rotate                  = true,
  $cfg_log_file_max_days                    = 7,
  $cfg_log_file_max_lines                   = 1000000,
  $cfg_log_file_max_lines_shift             = 28,
  $cfg_log_level                            = 'Info',
  $cfg_log_mode                             = 'console, file',
  $cfg_security_admin_password              = 'secret',
  $cfg_security_admin_user                  = 'admin',
  $cfg_security_cookie_remember_name        = 'grafana_remember',
  $cfg_security_cookie_username             = 'grafana_user',
  $cfg_security_data_source_proxy_whitelist = '',
  $cfg_security_disable_gravatar            = false,
  $cfg_security_login_remember_days         = 7,
  $cfg_security_secret_key                  = '90@oEImin',
  $cfg_server_http_addr                     = '127.0.0.1',
  $cfg_server_protocol                      = 'http',
  $cfg_users_allow_org_create               = false,
  $cfg_users_allow_sign_up                  = true,
  $cfg_users_auth_assign_org_role           = 'Viewer',
  $cfg_users_auto_assign_org                = true,
  $container_cfg                            = false,
  $container_params                         = {},
  $data_dir                                 = '/var/lib/grafana',
  $datasources                              = {},
  $install_dir                              = '/usr/share/grafana',
  $install_method                           = 'repo',
  $ldap_cfg                                 = false,
  $manage_package_repo                      = false,
  $package_name                             = 'grafana',
  $package_source                           = undef,
  $repo_name                                = 'stable',
  $rpm_iteration                            = undef,
  $service_name                             = 'grafana-server',
  $version                                  = 'latest',
) {

  class { ::grafana:
    archive_source      => $archive_source,
    cfg                 => {
      server => {
        protocol  => $cfg_server_protocol,
        http_addr => $cfg_server_http_addr,
      },
    'auth.anonymous' => {
      enabled  => $cfg_auth_anonymous_enabled,
      org_name => $cfg_auth_anonymous_org_name,
      org_role => $cfg_auth_anonymous_org_role,
     },
     'auth.basic' => {
       enabled => $cfg_auth_basic_enabled,
     },
     'auth.proxy' => {
       enabled         => $cfg_auth_proxy_enabled,
       header_name     => $cfg_auth_proxy_header_name,
       header_property => $cfg_auth_proxy_header_property,
       auto_sign_up    => $cfg_auth_proxy_auto_sign_up,
     },
     event_publisher => {
       enabled      => $cfg_event_publisher_enabled,
       rabbitmq_url => $cfg_event_publisher_rabbitmq_url,
       exchange     => $cfg_event_publisher_exchange,
     },
     'dashboards.json' => {
       enabled => $cfg_dashboards_json_enabled,
       path    => $cfg_dashboards_json_path,
     },
     database => {
       host     => $cfg_database_host,
       name     => $cfg_database_name,
       password => $cfg_database_password,
       path     => $cfg_database_path,
       'type'   => $cfg_database_type,
       user     => $cfg_database_user,
     },
     log => {
       mode       => $cfg_log_mode,
       buffer_len => $cfg_log_buffer_len,
       level      => $cfg_log_level,
     },
     'log.console' => {
       level => $cfg_log_console_level,
     },
     'log.file' => {
       log_rotate      => $cfg_log_file_log_rotate,
       max_lines       => $cfg_log_file_log_max_lines,
       max_lines_shift => $cfg_log_file_log_max_lines_shift,
       daily_rotate    => $cfg_log_file_log_daily_rotate,
       max_days        => $cfg_log_file_log_max_days,
     },
     security => {
       admin_user                  => $cfg_security_admin_user,
       admin_password              => $cfg_security_admin_password,
       secret_key                  => $cfg_security_secret_key,
       login_remember_days         => $cfg_security_login_remember_days,
       cookie_username             => $cfg_security_cookie_username,
       cookie_remember_name        => $cfg_security_cookie_remember_name,
       disable_gravatar            => $cfg_security_disable_gravatar,
       data_source_proxy_whitelist => $cfg_security_data_source_proxy_whitelist,
     },
     users => {
       allow_sign_up        => $cfg_users_allow_sign_up,
       allow_org_create     => $cfg_users_allow_org_create,
       auto_assign_org      => $cfg_users_auto_assign_org,
       auth_assign_org_role => $cfg_users_auth_assign_org_role,
      },
    },
    cfg_location        => $cfg_location,
    ldap_cfg            => $ldap_cfg,
    container_cfg       => $container_cfg,
    container_params    => $container_params,
    data_dir            => $data_dir,
    install_dir         => $install_dir,
    install_method      => $install_method,
    manage_package_repo => $manage_package_repo,
    package_name        => $package_name,
    package_source      => $package_source,
    repo_name           => $repo_name,
    rpm_iteration       => $rpm_iteration,
    service_name        => $service_name,
    version             => $version,
  }

  $datasource_defaults = {
    grafana_url      => 'http://localhost:3000',
    grafana_user     => $admin_user,
    grafana_password => $admin_password,
  }

  create_resources( ::profiles::metrics::grafana::datasource, $datasources, $datasource_defaults )
}
