# ----- variables to customize ----- #
$user_list = Get-Content .\names.txt
# ---------------------------------- #

#--uncomment to change executionpolicy and save value
#$get = Get-ExecutionPolicy
#SetExecutionPolicy -ExecutionPolicy Unrestricted -Force

#--remove user(s) from username list
foreach ($n in $user_list) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    Write-Host "Removing user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    Remove-AdUser -Identity $username
}

#--revert executionpolicy change
#SetExecutionPolicy -ExecutionPolicy $get -Force