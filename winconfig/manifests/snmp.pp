#Windows SNMP management
define winconfig::snmp (
  $ensure,
  $contact,
  $location,
  $community,
  $destination,
) {
  if versioncmp($::operatingsystemrelease, 6.1) < 0 {
    fail('Windows 2003 is not yet supported...')
  } elsif $ensure == 'present' {
      exec { 'Add SNMP Service':
        command  => 'Import-Module ServerManager; Add-WindowsFeature SNMP-Service',
        onlyif   => 'Import-Module ServerManager; if ((Get-WindowsFeature SNMP-Service).Installed) { exit 1 }',
        path     => $::path,
        provider => 'powershell',
      }
  }
    else {
      exec {'Remove SNMP Service':
        command  => 'Import-Module ServerManager; Remove-WindowsFeature SNMP-Service',
        unless   => 'Import-Module ServerManager; if ((Get-WindowsFeature SNMP-Service).Installed { exit 1 }',
        path     => $::path,
        provider => 'powershell',
      }
  }

  registry::value{'SNMP Community String':
    key   => 'hklm\system\CurrentControlSet\Services\SNMP\Parameters\Valid Communities',
    value => $community,
    type  => 'dword',
    data  => 4,
  }

  registry::value{'SNMP Trap Destination':
    key   => "hklm\\system\\CurrentControlSet\\Services\\SNMP\\Parameters\\TrapConfiguration\\${community}",
    value => '1',
    data  => $destination,
  }

  registry::value{'syscontact':
    key   => 'hklm\system\CurrentControlSet\Services\SNMP\Parameters\RFC1156Agent',
    value => 'sysContact',
    data  => $contact,
  }

  registry::value{'syslocation':
    key   => 'hklm\system\CurrentControlSet\Services\SNMP\Parameters\RFC1156Agent',
    value => 'sysLocation',
    data  => $location,
  }

  #service
  service {'SNMP':
    ensure => running,
    enable => true,
  }

}
