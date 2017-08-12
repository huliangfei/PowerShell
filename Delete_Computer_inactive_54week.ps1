<#      
.NOTES  
#===========================================================================  
# Script: Move_Servers_Into_OU.ps1   
# Author: 胡良飛   
# Date: 05/23/2017  
# Organization: Foxconn集團 iDPBG事業群   
# Comments:  Multiple Computer Account into desired OU 
#===========================================================================  
.DESCRIPTION  
        Move Computer Objects into desired OU 
#> 

## Import AD Module if Does not Exist 
if (! (get-Module ActiveDirectory)) 
{ 
## Write-Host "Importing AD Module....." -Fore green 
Import-Module ActiveDirectory 
## Write-Host "Completed..............." -Fore green 
} 


## Defining Source Path  
$SourceOU   = "CN=Computers,DC=dpbg,DC=lh,DC=com"  

## Defining Target Path  


## Defining Computers
$SourceComputers = Get-ADComputer -Filter * -Properties * -SearchBase $SourceOU

## 移動计算机账户到GL計算機目錄下：
## 查找Computers容器下GL-開頭的计算机，移动到觀瀾DPBG,Computers容器，并将结果存到 c:\movecomputersresult下以日期命名的文本文件中
## Get-ADComputer -Filter {(Name -like "GL-*") -and (OperatingSystem -eq "Windows XP Professional")} -Properties * -SearchBase "CN=Computers,DC=dpbg,DC=lh,DC=com" | Move-ADObject -TargetPath $GLXPTargetOU
