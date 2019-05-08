﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$silentArgs = '/S'

$pp = Get-PackageParameters
if ($pp['DIR']){	
  $silentArgs += " /D=`"$($pp['DIR'])`""
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'  
  file          = "$toolsDir\flrig-1.3.44_setup_x32.exe"  
  silentArgs    = $silentArgs
}

Install-ChocolateyInstallPackage @packageArgs
