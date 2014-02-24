#Windows SMB Share User - Defined Resource Type
define winconfig::share_adduser(
  $ensure,
  $share_name,
  $share_user,
  $share_access,
) {
  case $ensure {
    'present': {
      exec {"Grant ${share_user} access to ${share_name} on ${::hostname}":
        command  => "Grant-SmbShareAccess -Name ${share_name} -AccountName ${share_user} -AccessRight ${share_access} -Force",
        unless   => "If (Get-SmbShareAccess -Name ${share_name} | Where {\$_.AccountName -eq '${share_user}'} | Where {\$_.AccessRight -eq '${share_access}'}) { exit 0 } else { exit 1 }",
        provider => powershell,
      }
    }
    'absent': { fail('WIP') }
    default: { fail('Must specify ensure status') }
  }
}
