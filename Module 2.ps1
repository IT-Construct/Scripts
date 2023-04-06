# Module 2: Install AD-Domain-Services 
# Install the AD-Domain-Services feature 
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -Restart
Install-WindowsFeature RSAT-AD-Powershell

# Prompt user for Forest name, OU name and user details 
# Create AD Forest 
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "corp.greendata.com" `
-DomainNetbiosName "CORP" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
