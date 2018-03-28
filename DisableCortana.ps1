
# this gives you the ability to run the script without being admin 
if( [bool]([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -notcontains "S-1-5-32-544") {
    
    Start Powershell -ArgumentList "& '$MyInvocation.MyCommand.Path'" -Verb runas

}

Function DisableCortana
{  
    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"    
    IF(!(Test-Path -Path $path)) { 
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "Windows Search"
    } 
    Set-ItemProperty -Path $path -Name "AllowCortana" -Value 0 
    #Restart Explorer to change it immediately    
    Stop-Process -name explorer
}

# in order to run scripts, you have to change the execution policy
Set-ExecutionPolicy UnRestricted -Force

DisableCortana

# revert the execution policy back to normal
Set-ExecutionPolicy Restricted -Force
