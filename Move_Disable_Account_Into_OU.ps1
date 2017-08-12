#用户账户(User Accounts):
#
#将下列代码保存为*sp1文件，稍作修改即可。代码作用是搜索Accounts容器下的禁用的用户账户，然后移动到Disabled Accounts容器，并将结果存到 c:\moveusersresult下以日期命名的文本文件中：
#
#方法一：

import-module ActiveDirectory
$date = Get-date -uformat “%Y%m%d%H%M”
$useraccounts = get-aduser -filter * -properties useraccountcontrol -SearchBase ‘OU= Accounts,DC=domain,DC=com’ 
foreach($user in $useraccounts)
{
 if($user.useraccountcontrol -eq 546 -or $user.useraccountcontrol -eq 514)
  {
   $info = $user.name + “  ” + $user.distinguishedName
   $result = “`n$result” + ” ” + “$info`n”
   Get-ADUser $user | Move-ADObject -TargetPath ‘OU=Disabled Accounts,DC=domain,DC=com’
  }
 }
$result
$result > c:\moveusersresult\$date.txt

#方法二：

import-module ActiveDirectory
$date = Get-date -uformat “%Y%m%d%H%M”
$users=search-adaccount -accountdisabled -searchbase ‘OU= Accounts,DC=domain,DC=com’
foreach($user in $users)
{
  $info = $user.name + “  ” + $user.distinguishedName
  $result = “`n$result” + ” ” + “$info`n”
  Get-ADUser $user | Move-ADObject -TargetPath ‘OU=Disabled Accounts,DC=domain,DC=com’
}
$result
$result > c:\moveusersresult\$date.txt

#计算机账户：

#找下Client Computers容器下禁用的计算机，然后移动到Disabled Accounts容器，并将结果存到 c:\movecomputersresult下以日期命名的文本文件中：

import-module ActiveDirectory
$date = Get-date -uformat “%Y%m%d%H%M”
$users=search-adaccount -accountdisabled -searchbase ‘OU=Client Computers,DC=ku6,DC=corp’
foreach($user in $users)
{
  $info = $user.name + “  ” + $user.distinguishedName
  $result = “`n$result” + ” ” + “$info`n”
  Get-ADComputer $user | Move-ADObject -TargetPath ‘OU=Invalid Computers,DC=ku6,DC=corp’
}
$result
$result > c:\movecomputerresult\$date.txt
