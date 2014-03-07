#Base Profile for Windows Server
class profile::windows{
  winconfig::uac { "${::hostname}-uac": ensure => disabled, }
  winconfig::esc { "${::hostname}-esc": ensure => disabled, }
  winconfig::proxy { "${::hostname}-proxy": ensure => disabled, }
}
