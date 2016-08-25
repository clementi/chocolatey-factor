$version = '0.97'
$packageName = 'factor'
$url = 'http://downloads.factorcode.org/releases/0.97/factor-windows-x86-32-0.97.zip'
$checksum = '437575e6e1b967eeb017826157c382237d19a99c'
$checksumType = 'sha1'
$url64 = 'http://downloads.factorcode.org/releases/0.97/factor-windows-x86-64-0.97.zip'
$checksum64 = 'd014073a1faaf5c384faa8a69eb5ad89c02896c3'
$checksumType64 = 'sha1'
 
$binRoot = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$packageFullName = Join-Path $binRoot ($packageName + '-' + $version)

Install-ChocolateyZipPackage -PackageName $packageName -Url $url -Url64bit $url64 -UnzipLocation $packageFullName -Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64 -ChecksumType64 $checksumType64

$exes = Get-ChildItem $packageFullName -Include *.exe -Recurse
foreach ($exe in $exes) {
  New-Item "$exe.ignore" -Type File -Force | Out-Null
}

Install-BinFile -Name 'factor' -Path (Join-Path $packageFullName (Join-Path 'factor' 'factor.com'))