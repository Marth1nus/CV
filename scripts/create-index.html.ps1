pandoc README.md -o index.html
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
$html = Get-Content index.html -Raw
$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="favicon.svg" type="image/svg+xml">
  <title>CV Marthinus Prinsloo</title>
  </head>
<body>
$html
</body>
</html>
"@.Trim()
$html | Set-Content index.html -Encoding utf8