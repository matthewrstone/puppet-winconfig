Facter.add("win_dotnet3_version") do
  confine :osfamily => "windows"
  setcode do
    ps_exec  = 'C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe'
    ps_query = "$psq=(Get-ItemProperty -ErrorAction SilentlyContinue 'HKLM:\\Software\\Microsoft\\Net Framework Setup\\NDP\\v3.0').Version; If (!$psq) { echo 'false' } else { echo $psq }"
    ps_cmd   = (Facter::Util::Resolution.exec(%Q{#{ps_exec} -command "#{ps_query}"})).strip

    case ps_cmd
      when 'false'
        answer='notinstalled'
      else
        answer=ps_cmd
    end

    answer
  end
end
