# Remote Desktop Module
define winconfig::rdp(
  $ensure
) {
  include winconfig::params
  case $ensure {
    'present','enabled': { 
	  $rdp_data = 0

      # Ignore user errors on RDP connection
      registry_key  { 'hklm\SYSTEM\CurrentControlSet\Control\Terminal Server':
        ensure => present, 
      }  
      registry_value { 'hklm\SYSTEM\CurrentControlSet\Control\Terminal Server\IgnoreRegUserConfigErrors':
        type   => dword,
        data   => 1,
      }
    }
	'absent','disabled': { $rdp_data = 1 }
    default: { fail('You must specify ensure status...') }
  }

  registry_value { 'hklm\SYSTEM\CurrentControlSet\Control\Terminal Server\fDenyTSConnections':
    type   => dword,
    data   => $rdp_data,
  }
}  
