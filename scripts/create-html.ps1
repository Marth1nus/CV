pandoc README.md -o index.html --embed-resources
if ($LASTEXITCODE -ne 0) { Write-Error "Command Failed. exit code $LASTEXITCODE. Exiting early." ; exit $LASTEXITCODE }
@"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="favicon.svg" type="image/svg+xml">
  <title>CV Marthinus Prinsloo</title>
  </head>
<body>
$(Get-Content index.html -Raw)
</body>
</html>
"@.Trim() | Set-Content index.html -Encoding utf8
