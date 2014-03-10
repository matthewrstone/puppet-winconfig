# Remote Desktop Module
define winconfig::rdp(
  $ensure
) {
  include winconfig::params
  case $ensure {
    'present','enabled': {
      $rdp_data = 0

      registry::value { 'Terminal Server - User Config Errors':
        key    => 'hklm\SYSTEM\CurrentControlSet\Control\Terminal Server\IgnoreRegUserConfigErrors',
        type   => dword,
        data   => 1,
      }
    }
    'absent','disabled': { $rdp_data = 1 }
    default: { fail('You must specify ensure status...') }
  }

  registry::value { 'Terminal Server - Deny Connections':
    key    => 'hklm\SYSTEM\CurrentControlSet\Control\Terminal Server\fDenyTSConnections',
    type   => dword,
    data   => $rdp_data,
  }
}
