$ErrorActionPreference = "Stop"

function Add-LicenseToArchive {
    param(
        [string]$ArchivePath,
        [string]$LicenseSrc
    )
    
    $tempDir = "$env:TEMP\ymtm_license_$(Get-Random)"
    $zipPathTmp = "$tempDir\temp_new.zip"
    
    Write-Host "   - Extracting..." -ForegroundColor Cyan
    Expand-Archive -Path $ArchivePath -DestinationPath $tempDir -Force
    
    Write-Host "   - Finding theme folder..." -ForegroundColor Cyan
    $themeFolder = $null
    
    $dirs = Get-ChildItem -Path $tempDir -Directory
    foreach ($dir in $dirs) {
        if (Test-Path (Join-Path $dir.FullName "metadata.json")) {
            $themeFolder = $dir
            break
        }
    }
    
    if ($themeFolder) {
        $licenseDst = Join-Path $themeFolder.FullName "LICENSE"
        Write-Host "   - Adding LICENSE to folder: $($themeFolder.Name)" -ForegroundColor Cyan
    } else {
        $licenseDst = Join-Path $tempDir "LICENSE"
        Write-Host "   - Adding LICENSE to root" -ForegroundColor Cyan
    }
    Copy-Item -Path $LicenseSrc -Destination $licenseDst -Force
    
    Write-Host "   - Creating new archive..." -ForegroundColor Cyan
    Compress-Archive -Path "$tempDir\*" -DestinationPath $zipPathTmp -Force
    
    Write-Host "   - Replacing original..." -ForegroundColor Cyan
    Remove-Item -Path $ArchivePath -Force
    Move-Item -Path $zipPathTmp -Destination $ArchivePath -Force
    
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    
    Write-Host "   Done: $(Split-Path $ArchivePath -Leaf)" -ForegroundColor Green
}

Write-Host "=== Adding LICENSE to archives ===" -ForegroundColor Cyan

$distPath = "dist"
$themeName = "Rascal Does Not Dream"
$licenseSrc = "$themeName\LICENSE"

if (-not (Test-Path $distPath)) {
    Write-Host "ERROR: dist folder not found" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $licenseSrc)) {
    Write-Host "ERROR: LICENSE not found at $licenseSrc" -ForegroundColor Red
    exit 1
}

Write-Host "Processing .pext archive..." -ForegroundColor Yellow

Get-ChildItem -Path $distPath -Filter "*.pext" | ForEach-Object {
    $pextPath = $_.FullName
    $tempZipPath = "$env:TEMP\ymtm_temp_pext_$(Get-Random).zip"
    
    Write-Host "   Processing: $($_.Name)" -ForegroundColor Gray
    
    Write-Host "   - Converting .pext to .zip..." -ForegroundColor Cyan
    Copy-Item -Path $pextPath -Destination $tempZipPath -Force
    
    Add-LicenseToArchive -ArchivePath $tempZipPath -LicenseSrc $licenseSrc
    
    Write-Host "   - Converting back to .pext..." -ForegroundColor Cyan
    Move-Item -Path $tempZipPath -Destination $pextPath -Force
}

Write-Host ""
Write-Host "Processing .zip archive..." -ForegroundColor Yellow

Get-ChildItem -Path $distPath -Filter "*.zip" | ForEach-Object {
    Write-Host "   Processing: $($_.Name)" -ForegroundColor Gray
    Add-LicenseToArchive -ArchivePath $_.FullName -LicenseSrc $licenseSrc
}

Write-Host ""
Write-Host "=== Build complete! ===" -ForegroundColor Green
Write-Host "LICENSE added to .zip and .pext archives." -ForegroundColor Green