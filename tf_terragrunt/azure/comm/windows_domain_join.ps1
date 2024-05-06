[CmdletBinding()]
param (
  [Parameter()]
  [string]
  $user,
  # password
  [Parameter()]
  $pass
)

$ErrorActionPreference = "Stop"
try {
  Set-TimeZone -Name "Eastern Standard Time"
  Set-DnsClientGlobalSetting -SuffixSearchList @("parsons.com")
  $networkConfig = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'"
  $networkConfig.SetDynamicDNSRegistration($true, $true)
  Install-WindowsFeature SNMP-Service -IncludeAllSubFeature -IncludeManagementTools
  $secure_pass = $pass | ConvertTo-SecureString -AsPlainText -Force
  $DomainCred = New-Object -TypeName System.Management.Automation.PSCredential ("Parsons.com\$user", $secure_pass)
  Add-Computer -DomainName Parsons.com -Credential $DomainCred -OUPath "OU=Servers,OU=United States,DC=Parsons,DC=com" -force -Options JoinWithNewName, AccountCreate -Restart -ErrorAction Stop

  $progressPreference = 'SilentlyContinue'
  New-Item -ItemType Directory C:\\Masters -ErrorAction SilentlyContinue
  $source = 'http://txdal11sccmpr01.parsons.com/CCM_CLIENT/ccmsetup.exe'
  $ccmsetup = 'C:\\Masters\\ccmsetup.exe'
  Invoke-WebRequest $source -OutFile $ccmsetup -UseDefaultCredentials
  & $ccmsetup SMSSITECODE=D11 DNSSUFFIX=PARSONS.COM /BITSPriority:FOREGROUND /mp:txdal11sccmpr01.parsons.com
}
catch {
  $_ | Out-File -FilePath "C:\build_log.txt"
}
