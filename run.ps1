# Zenergia Ecosystem Boot (Minimalista)
Write-Host "--- ZENERGIA CORE ACTIVATED ---" -ForegroundColor Blue

# Lanzar servidor en segundo plano
Start-Process "python" "-m http.server 8000" -WindowStyle Hidden

# Abrir el Lab en HTTP (No HTTPS)
Start-Process "http://localhost:8000"

Write-Host "Z-Strum Telemetría escuchando en puerto 8000..." -ForegroundColor Cyan