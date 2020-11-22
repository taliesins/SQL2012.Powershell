$package = 'SQL2008R2.PowerShell'

try {
  $params = @{
    packageName = $package;
    fileType = 'msi';
    silentArgs = '/quiet';
    url = 'https://download.microsoft.com/download/F/3/C/F3C64941-22A0-47E9-BC9B-1A19B4CA3E88/ENU/x86/PowerShellTools.msi';
    url64bit = 'https://download.microsoft.com/download/F/3/C/F3C64941-22A0-47E9-BC9B-1A19B4CA3E88/ENU/x64/PowerShellTools.msi';
  }

  Install-ChocolateyPackage @params

  # install both x86 and x64 editions since x64 PS supports both
  $IsSytem32Bit = (($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
    ($Env:PROCESSOR_ARCHITEW6432 -eq $null))
  if (!$IsSytem32Bit)
  {
    $params.url64bit = $params.url
    Install-ChocolateyPackage @params
  }

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
