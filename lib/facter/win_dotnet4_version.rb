Facter.add("win_dotnet4_version") do
  confine :osfamily => "windows"
  
  ps_exec  = 'C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe'
  ps_query = "$psq=(Get-ItemProperty -ErrorAction SilentlyContinue 'HKLM:\\Software\\Microsoft\\Net Framework Setup\\NDP\\v4\\Full' Release).Release; If (!$psq) { echo 'false' } else { echo $psq }"
  ps_cmd   = (Facter::Util::Resolution.exec(%Q{#{ps_exec} -command "#{ps_query}"})).strip

  setcode do
    case ps_cmd
      when 'false'
        answer='notinstalled'
      when '378379'
        answer='4.5'
      when '378675'
        answer='4.5.1'
      when '378758'
        answer='4.5.1'
      when '379893'
        answer='4.5.2'
      else
        answer='unknown'
    end
  end
end
