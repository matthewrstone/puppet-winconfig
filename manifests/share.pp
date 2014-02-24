# Windows SMB Share Defined Resource Type
# Matthew Stone (matt@souldo.net)
# For Usage, consult README.md
define winconfig::share(
  $ensure,
  $share_name,
  $share_path,
  $share_admin,
) {
  case $::operatingsystemversion {
    /2003/: { fail('Windows 2003 is unsupported') }
    /2008/: { fail('Windows 2008 is unsupported') }
    /2012/: { info('Windows 2012 is supported') }
    default: { fail("Unknown operating system - ${::operatingsystemversion}") }
  }

  case $ensure {
    'present': {
      file {$share_path:
        ensure => directory,
      } ->
      exec {"Create share ${share_name} on ${::hostname}":
        command    => "New-SmbShare -Name ${share_name} -Path ${share_path} -FullAccess ${share_admin}",
        unless     => "if ((Get-SmbShare | Where {\$_.Name -contains '${share_name}'}).Name -contains '${share_name}') { exit 0 } else { exit 1 }",
        provider   => powershell,
      }
    }

    'absent': { fail('No removal code yet') }
    default: { fail('Must specify ensure status') }
  }
}
