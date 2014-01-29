#User Access Control  management
define winconfig::uac (
  $ensure,
) {
  if versioncmp($::operatingsystemrelease, 6.1) < 0 {
    fail('Windows 2003 is not supported...')
  } elsif $ensure == 'present' {
      registry::value{'UAC':
        key    => 'hklm\software\Microsoft\Windows\CurrentVersion\Policies\System',
        value  => 'EnableLUA',
        type   => 'dword',
        data   => 1,
    }
  } else {
      registry::value{'UAC':
        key   => 'hklm\software\Microsoft\Windows\CurrentVersion\Policies\System',
        value => 'EnableLUA',
        type  => 'dword',
        date  => 0,
      }
    }
  reboot { 'UAC':
    subscribe => Registry::value['UAC'],
}
