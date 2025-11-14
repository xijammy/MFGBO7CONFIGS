# === BO7 Auto Updater ===

# Where to temporarily download the files
$src = "$env:USERPROFILE\Downloads\BO7-Files"

# The Call of Duty Players folder (hidden on Windows but still accessible)
$dst = "$env:LOCALAPPDATA\Activision\Call of Duty\players"

# Make sure the temporary folder exists
New-Item -ItemType Directory -Force -Path $src | Out-Null

# List of files to download
$files = @(
    @{ url = "https://github.com/xijammy/MFGBO7CONFIGS/blob/main/s.1.0.cod25.m"; name = "s.1.0.cod25.m" }
    @{ url = "https://github.com/xijammy/MFGBO7CONFIGS/blob/main/s.1.0.cod25.txt0"; name = "s.1.0.cod25.txt0" }
    @{ url = "https://github.com/xijammy/MFGBO7CONFIGS/blob/main/s.1.0.cod25.txt1"; name = "s.1.0.cod25.txt1" }
)

# Download each file
foreach ($f in $files) {
    $out = Join-Path $src $f.name
    Invoke-WebRequest -Uri $f.url -OutFile $out
    Write-Host "Downloaded $($f.name)"
}

# Replace files inside the BO7 Players folder
Copy-Item "$src\*" $dst -Force

Write-Host "`n✔ BO7 configuration files replaced successfully."
