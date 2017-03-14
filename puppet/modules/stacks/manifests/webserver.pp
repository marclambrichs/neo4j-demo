class stacks::webserver (
  $type          = 'nginx',
  $uwsgi_enabled = false,
) {

    case $type {
      'nginx': {
        class { '::profiles::nginx': }
        if $uwsgi_enabled {
          class { '::profiles::uwsgi': }
        }
      }
      default: {
        fail("webserver type ${type} unknown")
      }
    }
}
