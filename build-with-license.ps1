$ErrorActionPreference = "Stop"

Write-Host "=== Adding LICENSE to archives ===" -ForegroundColor Cyan

$distPath = "dist"
$themeName = "Rascal Does Not Dream"
$licenseSrc = "$themeName/LICENSE"
$licenseDst = "LICENSE"

if (-not (Test-Path $licenseSrc)) {
    Write-Host "ERROR: LICENSE not found at $licenseSrc" -ForegroundColor Red
    exit 1
}

Write-Host "Processing .pext archive..." -ForegroundColor Yellow

Get-ChildItem -Path $distPath -Filter "*.pext" | ForEach-Object {
    $pextPath = $_.FullName
    $tempZipPath = "$env:TEMP\ymtm_temp_pext_$(Get-Random).zip"
    $tempDir = "$env:TEMP\ymtm_build_$(Get-Random)"

    Write-Host "   Processing: $($_.Name)" -ForegroundColor Gray

    Write-Host "   - Converting .pext to .zip..." -ForegroundColor Cyan
    Copy-Item -Path $pextPath -Destination $tempZipPath -Force

    Write-Host "   - Extracting..." -ForegroundColor Cyan
    Expand-Archive -Path $tempZipPath -DestinationPath $tempDir -Force

    Write-Host "   - Adding LICENSE..." -ForegroundColor Cyan
    Copy-Item -Path $licenseSrc -Destination "$tempDir\$licenseDst" -Force

    Write-Host "   - Creating new .zip with Python..." -ForegroundColor Cyan
    $zipPathTmp = "$tempDir\temp_new.zip"
    
    python -c @"
import zipfile
import os
import sys

src = r'$($tempDir -replace '\\', '\\\\')'
dst = r'$zipPathTmp'

with zipfile.ZipFile(dst, 'w', zipfile.ZIP_DEFLATED) as z:
    for root, dirs, files in os.walk(src):
        for file in files:
            full_path = os.path.join(root, file)
            arcname = os.path.relpath(full_path, src)
            z.write(full_path, arcname)
"@

    Write-Host "   - Converting back to .pext..." -ForegroundColor Cyan
    Remove-Item -Path $tempZipPath -Force
    
    Move-Item -Path $zipPathTmp -Destination $pextPath -Force
    
    Remove-Item -Path $tempDir -Recurse -Force

    Write-Host "   Done: $(Split-Path $pextPath -Leaf)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Processing .zip archive..." -ForegroundColor Yellow

Get-ChildItem -Path $distPath -Filter "*.zip" | ForEach-Object {
    $zipPath = $_.FullName
    $tempDir = "$env:TEMP\ymtm_zip_$(Get-Random)"

    Write-Host "   Processing: $($_.Name)" -ForegroundColor Gray

    Write-Host "   - Extracting..." -ForegroundColor Cyan
    Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force

    Write-Host "   - Adding LICENSE..." -ForegroundColor Cyan
    Copy-Item -Path $licenseSrc -Destination "$tempDir\$licenseDst" -Force

    Write-Host "   - Creating new .zip with Python..." -ForegroundColor Cyan
    $zipPathTmp = "$tempDir\temp_new.zip"
    
    python -c @"
import zipfile
import os
import sys

src = r'$($tempDir -replace '\\', '\\\\')'
dst = r'$zipPathTmp'

with zipfile.ZipFile(dst, 'w', zipfile.ZIP_DEFLATED) as z:
    for root, dirs, files in os.walk(src):
        for file in files:
            full_path = os.path.join(root, file)
            arcname = os.path.relpath(full_path, src)
            z.write(full_path, arcname)
"@

    Write-Host "   - Replacing original .zip..." -ForegroundColor Cyan
    Remove-Item -Path $zipPath -Force
    Move-Item -Path $zipPathTmp -Destination $zipPath -Force
    
    Remove-Item -Path $tempDir -Recurse -Force

    Write-Host "   Done: $($_.Name)" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Build complete! ===" -ForegroundColor Green
Write-Host "LICENSE added to .zip and .pext archives." -ForegroundColor Green