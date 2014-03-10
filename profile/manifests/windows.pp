#Base Profile for Windows Server
class profile::windows{
  winconfig::uac { "${::hostname}-uac": ensure => absent, }
  winconfig::esc { "${::hostname}-esc": ensure => absent, }
  winconfig::rdp { "${::hostname}-rdp": ensure => present, }
  winconfig::ipv6 { "${::hostname}-ipv6": ensure => absent, }
}
