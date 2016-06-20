Facter.add("win_powershell_version") do
  confine :osfamily => "windows"

  setcode do
    ps_exec  = 'C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe'
    ps_cmd   = '($PSVersionTable.Version).Major'

    Facter::Util::Resolution.exec(%Q{#{ps_exec} -command #{ps_cmd}}).strip
  end
end
