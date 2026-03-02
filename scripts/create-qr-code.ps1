param(
  [string]$Url = "https://marth1nus.github.io/CV",
  [switch]$SingleLine,
  [switch]$Embed,
  [string]$QrCodeTempFileName = "qr.temp"
)

wsl qrencode $URl -o "$QrCodeTempFileName.png" -m 1 -l H 
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
$qrBase64 = [System.Convert]::ToBase64String([IO.File]::ReadAllBytes("$QrCodeTempFileName.png"))
Remove-Item "$QrCodeTempFileName.png"
$svg = @"
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1 1" width="2cm">
  <defs>
    <symbol id="GitHubLogo" viewBox="0 0 24 24">
      <!-- Path copied from "https://github.com" webpage 2026-02 -->
      <path d="M12 1C5.923 1 1 5.923 1 12c0 4.867 3.149 8.979 7.521 10.436.55.096.756-.233.756-.522 0-.262-.013-1.128-.013-2.049-2.764.509-3.479-.674-3.699-1.292-.124-.317-.66-1.293-1.127-1.554-.385-.207-.936-.715-.014-.729.866-.014 1.485.797 1.691 1.128.99 1.663 2.571 1.196 3.204.907.096-.715.385-1.196.701-1.471-2.448-.275-5.005-1.224-5.005-5.432 0-1.196.426-2.186 1.128-2.956-.111-.275-.496-1.402.11-2.915 0 0 .921-.288 3.024 1.128a10.193 10.193 0 0 1 2.75-.371c.936 0 1.871.123 2.75.371 2.104-1.43 3.025-1.128 3.025-1.128.605 1.513.221 2.64.111 2.915.701.77 1.127 1.747 1.127 2.956 0 4.222-2.571 5.157-5.019 5.432.399.344.743 1.004.743 2.035 0 1.471-.014 2.654-.014 3.025 0 .289.206.632.756.522C19.851 20.979 23 16.854 23 12c0-6.077-4.922-11-11-11Z" />
    </symbol>
    <mask id="QrDotsMask">
      <image width="1" style="image-rendering: pixelated; filter: invert(1)" href="data:image/png;base64,$qrBase64" />
      <circle cx="0.5" cy="0.5" r="0.2" fill="black" />
    </mask>
  </defs>
  <rect mask = "url(#QrDotsMask)"
    width    = "1"
    height   = "1"
    fill     = "currentColor" />
  <use href = "#GitHubLogo"
    x       = "0.3"
    y       = "0.3"
    width   = "0.4"
    height  = "0.4"
    fill    = "currentColor" />
</svg>
"@
if ($SingleLine) {
  $svg = $svg -replace '(\w+)\s*?=\s*?"', '$1="'
  $svg = $svg -replace '\r?\n\s*', ' '
  $svg = $svg -replace '> <', '><'
}
return $svg