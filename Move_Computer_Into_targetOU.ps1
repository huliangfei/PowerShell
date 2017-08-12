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
$GLXPTargetOU   =  "OU=WindowsXP,OU=Computers,OU=DPBG,DC=dpbg,DC=lh,DC=com" 
$GL7TargetOU   =  "OU=Windows7,OU=Computers,OU=DPBG,DC=dpbg,DC=lh,DC=com" 
$LHXPTargetOU   =  "OU=WindowsXP,OU=Computers,OU=DPBG-LH,DC=dpbg,DC=lh,DC=com"
$LH7TargetOU   =  "OU=Windows7,OU=Computers,OU=DPBG-LH,DC=dpbg,DC=lh,DC=com"  
$GVDITargetOU  =  "OU=Cloud-GL,DC=dpbg,DC=lh,DC=com"  

## Defining Computers
$SourceComputers = Get-ADComputer -Filter * -Properties * -SearchBase $SourceOU

## 移動计算机账户到GL計算機目錄下：
Switch ($SourceComputers)
{
	## GL
	## 移動以GL開頭且系統版本為WindowsXP的電腦到指定群組
	{($_.Name -like "GL-*") -and ($_.OperatingSystem -eq "Windows XP Professional")}{Get-ADComputer $_ | Move-ADObject -TargetPath $GLXPTargetOU}
	## 移動以GL開頭且系統版本為WindowsXP的電腦到指定群組
	{($_.Name -like "GL-*") -and ($_.OperatingSystem -eq "Windows 7 企業版")}{Get-ADComputer $_ | Move-ADObject -TargetPath $GL7TargetOU}
	## LH
	## 移動以LH開頭且系統版本為WindowsXP的電腦到指定群組
	{($_.Name -like "LH-*") -and ($_.OperatingSystem -eq "Windows XP Professional")}{Get-ADComputer $_ | Move-ADObject -TargetPath $LHXPTargetOU}
	## 移動以LH開頭且系統版本為WindowsXP的電腦到指定群組
	{($_.Name -like "LH-*") -and ($_.OperatingSystem -eq "Windows 7 企業版")}{Get-ADComputer $_ | Move-ADObject -TargetPath $LH7TargetOU}
	## GL雲桌面
	## 移動以LH開頭且系統版本為WindowsXP的電腦到指定群組
	{($_.Name -like "GVDI*")}{Get-ADComputer $_ | Move-ADObject -TargetPath $GVDITargetOU}
}


## 移動计算机账户到GL計算機目錄下：
## 查找Computers容器下GL-開頭的计算机，移动到觀瀾DPBG,Computers容器，并将结果存到 c:\movecomputersresult下以日期命名的文本文件中
## Get-ADComputer -Filter {(Name -like "GL-*") -and (OperatingSystem -eq "Windows XP Professional")} -Properties * -SearchBase "CN=Computers,DC=dpbg,DC=lh,DC=com" | Move-ADObject -TargetPath $GLXPTargetOU
