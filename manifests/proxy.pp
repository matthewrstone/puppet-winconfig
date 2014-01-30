#Windows Proxy Settings
define winconfig::proxy (
  $ensure,
  $proxyserver,
  $proxyoverride,
){
  if $ensure == 'present' {
    registry::value{'ProxyEnable':
      key   => 'hklm\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
      value => 'ProxyEnable',
      type  => 'dword',
      data  => 1,
    }
  } else {
    registry::value{'ProxyEnable':
      key   => 'hklm\Software\Microsoft\Windows\CurrentVersion\Internet Settings',
      value => 'ProxyEnable',
      type  => 'dword',
      data  => 0,
    }
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
}
