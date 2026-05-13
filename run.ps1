# Zenergia Ecosystem Boot v2.4
Write-Host "--- ZENERGIA CORE ACTIVATED ---" -ForegroundColor Blue

# Port Cleanup (macOS/Linux compatible)
if ($IsMacOS -or $IsLinux) {
    Write-Host "Clearing resonance ports (8000, 8501)..." -ForegroundColor Gray
    # Kill process on port 8000
    $p8000 = lsof -ti:8000
    if ($p8000) { kill -9 $p8000 }
    
    # Kill process on port 8501
    $p8501 = lsof -ti:8501
    if ($p8501) { kill -9 $p8501 }
}

# Launch Frontend (Server)
Start-Process "python3" "-m http.server 8000"
Write-Host "1. Frontend: http://localhost:8000" -ForegroundColor Cyan

# Launch Backend (Z-ARPA Auditor)
Start-Process "streamlit" "run zarpa.py --server.port 8501"
Write-Host "2. Auditor: http://localhost:8501" -ForegroundColor Cyan

Write-Host "System fully synchronized BY JALKO. Ready for Lab Audit." -ForegroundColor Green