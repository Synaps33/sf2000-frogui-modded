Get-ChildItem -Recurse -File -Filter "logo.png" | ForEach-Object {
    $NewName = Join-Path $_.DirectoryName "background.png"

    if (!(Test-Path $NewName)) {
        Rename-Item $_.FullName "background.png"
        Write-Host "OK: $($_.DirectoryName)"
    } else {
        Write-Host "Pominięto: $($_.DirectoryName)"
    }
}