#Windows Proxy Settings
define winconfig::proxy (
  $ensure,
  $proxyserver=UNDEF,
  $proxyoverride=UNDEF,
){
  include winconfig::params
  case $ensure {
    'present','enabled': { 
	  $proxy_data = 1 
	  registry::value{'ProxyServer':
        key   => 'hklm\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
        value => 'ProxyServer',
        type  => 'dword',
        data  => $proxyserver
      }
      registry::value{'ProxyOverride':
        key   => 'hklm\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
        value => 'ProxyOverride',
        type  => 'dword',
        data  => $proxyoverride,
      }
      registry::value{'ProxyPerUserSettings':
        key   => 'hklm\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings',
        value => 'ProxySettingsPerUser',
        type  => 'dword',
        data  => 0
      }
	}
	'absent','disabled': { $proxy_data = 0 }
    default: { fail('You must specify ensure status...') }
  }
  registry::value{'ProxyEnable':
    key   => 'hklm\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
    value => 'ProxyEnable',
    type  => 'dword',
    data  => $proxy_data,
  }
}
