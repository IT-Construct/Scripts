echo "Please input employee's information"
$name Read-Host -Prompt "Full Name: "
$gname = Read-Host -Prompt "Given Name:
$sname = Read-Host -Prompt "Surname: "
$acc = Read-Host -Prompt "Account Name:
Stitle=Read-Host -Prompt "Title: "
$com = Read-Host -Prompt "Company: "
$dep Read-Host -Prompt "Department: "
$email = Read-Host -Prompt "Email Address: "
$org = Read-Host -Prompt "Organization: "
# Create new Organizational Units (OU) in AD
New-ADOrganizationalUnit -Name $org -Path “DC=corp,DC=greendata,DC=com”
# Create new users in AD 
New-Aduser -Name $name -GivenName $gname -Surname $sname -SamAccountName $acc -Title $title -company $com -Department $dep -EmailAddress $email -Path “OU=${org},DC=corp,DC=greendata,DC=com”
