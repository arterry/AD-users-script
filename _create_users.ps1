# ----- variables to customize ----- #
$user_password   = "Password1"
$user_list = Get-Content .\names.txt
# ---------------------------------- #

#--possible executionpolicy change and save value
#$get = Get-ExecutionPolicy
#SetExecutionPolicy -ExecutionPolicy Unrestricted -Force

$password = ConvertTo-SecureString $user_password -AsPlainText -Force

#--creates active directory organizational unit
New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false

#--run through every new username list
foreach ($n in $user_list) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    New-AdUser -AccountPassword $password `
               -GivenName $first `
               -Surname $last `
               -DisplayName $username `
               -Name $username `
               -EmployeeID $username `
               -PasswordNeverExpires $true `
               -Path "ou=_Users,$(([ADSI]`"").distinguishedName)" `
               -Enabled $true
}

#--revert executionpolicy change
#SetExecutionPolicy -ExecutionPolicy $get -Force