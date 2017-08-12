<#      
.NOTES  
#===========================================================================  
# Script: Move_WSUSComputers.ps1   
# Author: 胡良飛   
# Date: 05/23/2017  
# Organization: Foxconn集團 iDPBG事業群   
# Comments:  Multiple Computer Account into desired Group
#===========================================================================  
.DESCRIPTION  
        Move WSUS Computer Objects into desired Group 
#> 

$wsusclient = Get-WsusComputer -ComputerTargetGroups "尚未指派的電腦" 
Switch ($wsusclient)
{
	##移動電腦角色為Server的電腦到Server群組
	{$_.ComputerRole -eq "Server"}{Add-WsusComputer -Computer $_ -TargetGroupName "Server"}
	##移動電腦IP地址以172開頭的電腦到SFC群組
	{$_.IPAddress -like "172.*"}{Add-WsusComputer -Computer $_ -TargetGroupName "SFC"}
	##移動電腦IP地址以10開頭的電腦到Office群組
	{$_.IPAddress -like "10.*"}{Add-WsusComputer -Computer $_ -TargetGroupName "Office"}
}
