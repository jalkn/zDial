# Zenergia Ecosystem Boot v2.3
Write-Host "--- ZENERGIA CORE ACTIVATED ---" -ForegroundColor Blue

# Cleanup: Ensure port 8000 is available
if ($IsMacOS -or $IsLinux) {
    kill -9 $(lsof -ti:8000) 2>$null
}

# Launch Frontend (Server)
Start-Process "python3" "-m http.server 8000"
Write-Host "1. Frontend: http://localhost:8000" -ForegroundColor Cyan

# Launch Backend (Z-ARPA Auditor)
# Using a fixed port for consistency in the Lab Log
Start-Process "streamlit" "run zarpa.py --server.port 8501"
Write-Host "2. Auditor: http://localhost:8501" -ForegroundColor Cyan

Write-Host "System synchronized. Ready for Laboratory Audit." -ForegroundColor Green