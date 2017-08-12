<#      
.NOTES  
#===========================================================================  
# Script: Move_Servers_Into__OU.ps1   
# Created With:ISE 3.0   
# Author: Casey Dedeal   
# Date: 05/04/2016 23:11:04   
# Organization: ETC Solutions   
# File Name: Move_Servers_Into__OU.ps1  
# Comments:  Multiple Computer Account into desired OU 
#===========================================================================  
.DESCRIPTION  
        Move Computer Objects into desired OU 
        Get-Content C:\Temp\list2.txt ( You need to have list of servers ) 
        sample list 
        PC1 
        PC2 
        PC3 
 
 
#>  
 
 
## Import AD Module if Does not Exist 
if (! (get-Module ActiveDirectory)) 
{ 
Write-Host "Importing AD Module....." -Fore green 
Import-Module ActiveDirectory 
Write-Host "Completed..............." -Fore green 
} 
 
 
## Adding Varibles 
$Space   =  Write-Host "" 
$Sleep   =  Start-Sleep -Seconds 3 
 
## Reading list of computers from csv and loading into variable  
$computers = Get-Content C:\Temp\Computer_list.txt 
$path      = "C:\Temp\Computer_list.txt" 
## verification 
if (! (Test-Path $Path)) { 
     
    Write-Host "List of computers  List txt does not exist" 
 
} 
 
 
## Defining Target Path  
$TargetOU   =  "OU=Win2012,OU=Servers,OU=Contoso,DC=com"  
$countPC    = ($computers).count  
 
$Space   =  Write-Host "" 
$Sleep   =  Start-Sleep -Seconds 3 
write-host "This Script will move Computer Accounts" -Fore green 
write-host "Destination location is (Win2012 )     " -Fore green 
 
 
## Provide details 
write-host "List of Computers............." -Fore green 
$computers 
write-host ".............................." -Fore green 
$Space   
$Sleep 
ForEach( $computer in $computers){ 
    write-host "moving computers..." 
    Get-ADComputer $computer | 
    Move-ADObject -TargetPath $TargetOU 
} 
 
$Space   
$Sleep 
write-host "Completed....................." -Fore green 
Write-Host "Moved $countPC Servers........" 
Write-Host "Destination OU $TargetOU......"
