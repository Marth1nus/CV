param(
  [string]$Path = ".\README.md"
)
$qrCodeReplaces = @(, 
  @("Online CV QR Code", "https://marth1nus.github.io/CV")
)
$readme = Get-Content $Path -Raw
foreach ($qrCodeReplace in $qrCodeReplaces) {
  $id, $url = $qrCodeReplace
  $id = "$id".Trim()
  $idReg = [Regex]::Escape($id)
  $svg = . "$PSScriptRoot\create-qr-code.ps1" -Url $url -SingleLine
  $svg = $svg -replace "<svg", "<svg id=`"$id`""
  $readme = $readme -replace "<svg\s+id=`"$idReg`"[\s\S]*?/svg>", $svg
}
$readme | Set-Content $Path -NoNewline -Encoding utf8
