#IPv6 Management
define winconfig::ipv6 (
  $ensure,
  $state = UNDEF,
) {
  include winconfig::params
  case $ensure {
    'present','enabled': {
      case $state {
        UNDEF,'all': { $ipv6_data = '0' }
        'preferred': { $ipv6_data = '0x20' }
        'nontunnel': { $ipv6_data = '0x10' }
        'tunnel': { $ipv6_data = '0x01' }
        default: { $ipv6_data = '0' }
      }
	}
    'absent','disabled': { $ipv6_data = '0xffffffff' }
    default: { fail('You must specify ensure status...') }
  }
  registry::value{'ipv6':
    key    => 'hklm\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters',
    value  => 'DisabledComponents',
    type   => 'dword',
    data   => $ipv6_data,
  }
  reboot {'ipv6':
    subscribe => Registry::Value['ipv6'],
  }
}