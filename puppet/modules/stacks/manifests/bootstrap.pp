class stacks::bootstrap (
  $repos = false,
) {
  if $repos {
    class { '::profiles::repositories': }
  }
}
