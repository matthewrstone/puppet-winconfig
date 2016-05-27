Facter.add("win_dotnet4_version") do
  confine :osfamily => "windows"

  setcode do
    ps_exec  = 'C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe'
    ps_cmd   = '($PSVersionTable.PSVersion).Major'

    Facter::Util::Resolution.exec(%Q{#{ps_exec} -command #{ps_cmd}}).strip
  end
end
