# Zenergia Ecosystem Boot v2.7
Write-Host "--- ZENERGIA CORE ACTIVATED ---" -ForegroundColor Blue

# Persistence check
if (!(Test-Path "data/img")) { New-Item -ItemType Directory -Path "data/img" }

# Port Cleanup
if ($IsMacOS -or $IsLinux) {
    $p8000 = lsof -ti:8000; if ($p8000) { kill -9 $p8000 }
    $p8501 = lsof -ti:8501; if ($p8501) { kill -9 $p8501 }
}

# Launch Services
Start-Process "python3" "-m http.server 8000"
Start-Process "streamlit" "run zarpa.py --server.port 8501"
Write-Host "System fully synchronized BY JALKO. Ready for Weight-Audit." -ForegroundColor Green