# Create new Organizational Units (OU) in AD
New-ADOrganizationalUnit -Name “Engineering” -Path “DC=corp,DC=greendata,DC=com”
# Create new users in AD 
New-Aduser -Name "Jordan Marshall" -GivenName "Jordan" -Surname "Marshall" -SamAccountName "JMarshall" -Title "TPS Reporting Lead" -company "GreenData" -Department "TPS" -EmailAddress "MarshallJordan@greendata.com" -Path “OU=Engineering,DC=corp,DC=greendata,DC=com”
