# Zenergia Ecosystem Boot v2.5
Write-Host "--- ZENERGIA CORE ACTIVATED ---" -ForegroundColor Blue

# Ensure data persistence layer exists
if (!(Test-Path "data")) { New-Item -ItemType Directory -Path "data" }

# Port Cleanup (macOS/Linux/Windows compatible)
if ($IsMacOS -or $IsLinux) {
    Write-Host "Clearing resonance ports (8000, 8501)..." -ForegroundColor Gray
    $p8000 = lsof -ti:8000
    if ($p8000) { kill -9 $p8000 }
    $p8501 = lsof -ti:8501
    if ($p8501) { kill -9 $p8501 }
}

# Launch Frontend (Server)
Start-Process "python3" "-m http.server 8000"
Write-Host "1. Frontend Active: http://localhost:8000" -ForegroundColor Cyan

# Launch Backend (Z-ARPA Auditor)
Start-Process "streamlit" "run zarpa.py --server.port 8501"
Write-Host "2. Auditor Active: http://localhost:8501" -ForegroundColor Cyan

Write-Host "System fully synchronized BY JALKO. Data Science pipeline ready." -ForegroundColor Green