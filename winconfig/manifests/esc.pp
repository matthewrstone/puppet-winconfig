# WinConfig - Internet Explorer Enhanced Security Configuration (IE ESC)
define winconfig::esc(
  $ensure,
) {
  include winconfig::params
  case $ensure {
    'present','enabled': { $esc_data = 1 }
    'absent','disabled': { $esc_data = 0 }
    default: { fail('You must specify ensure status...') }
  }
  registry::value { 'IE ESC':
    key    => 'hklm\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}',
    value  => 'IsInstalled',
    type   => dword,
    data   => $esc_data,
  }
}