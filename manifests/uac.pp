#User Access Control management
define winconfig::uac (
  $ensure,
) {
  include winconfig::params
  case $ensure {
    'present','enabled': { $uac_data = 1 }
    'absent','disabled': { $uac_data = 0 }
    default: { fail('You must specify ensure status...') }
    }
  registry::value{'UAC':
    key    => 'hklm\software\Microsoft\Windows\CurrentVersion\Policies\System',
    value  => 'EnableLUA',
    type   => 'dword',
    data   => $uac_data,
  }
  reboot { 'UAC':
    subscribe => Registry::Value['UAC'],
  }
}
