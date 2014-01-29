#Manage DNS search domain suffix
define winconfig::searchdomains(
  $domains
) {
  registry::value{'Windows DNS Suffix Search Order':
    key   => 'hklm\system\CurrentControlSet\Services\TCPIP\Parameters',
    value => 'SearchList',
    data  => $domains,
  }
}

