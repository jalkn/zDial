# run.ps1 - Zenergia Unified Engine | Synchronized Edition
Write-Host "Sincronizando Partitura Zenergia..." -ForegroundColor Cyan

# 1. SETUP DE DIRECTORIOS
if (!(Test-Path "data")) { New-Item -ItemType Directory -Path "data" | Out-Null }
$dbPath = "$PSScriptRoot/data/zenergia_db.json"

# 2. LÓGICA DE SETS: FIBONACCI LUNAR
$lunarIllumination = 0.35 
$fib = @(3, 5, 8, 13, 21)
$index = [math]::Floor($lunarIllumination * ($fib.Count - 1))
$sets = $fib[$index]

# 3. LÓGICA DE ACCIONES Y REPS
$now = Get-Date
$hour = $now.Hour
$day = $now.Day

if ($hour -ge 5 -and $hour -lt 11) { $cuadrante = "SURGE"; $baseAngle = 45; $combo = "SU" }
elseif ($hour -ge 11 -and $hour -lt 17) { $cuadrante = "PACE"; $baseAngle = 90; $combo = "PSL" }
elseif ($hour -ge 17 -and $hour -lt 23) { $cuadrante = "UNDER"; $baseAngle = 180; $combo = "ULS" }
else { $cuadrante = "LIFT"; $baseAngle = 360; $combo = "LP" }

if ($day % 2 -eq 0) { 
    $charArray = $combo.ToCharArray()
    [array]::Reverse($charArray)
    $combo = -join $charArray
}

$reps = [math]::Abs($baseAngle - $day)
$dial = "$sets$combo$reps"

# 4. EXPORTACIÓN PARA Z-ARPA (Corregido para evitar InvalidOperation)
$dataEntry = [ordered]@{
    timestamp = $now.ToString("yyyy-MM-dd HH:mm:ss")
    dial      = $dial
    protocol  = "PULS"
    sets      = $sets
    reps      = $reps
    cuadrante = $cuadrante
    status    = "TUNED"
}

# Forzamos que $currentData sea siempre un Array @()
[array]$currentData = if (Test-Path $dbPath) { 
    $content = Get-Content $dbPath -Raw
    if (-not [string]::IsNullOrWhiteSpace($content)) {
        # El truco: Envolvemos el resultado en @() para asegurar que sea Array
        @($content | ConvertFrom-Json) 
    } else { @() }
} else { @() }

$currentData += New-Object PSObject -Property $dataEntry

$currentData | ConvertTo-Json -Depth 4 | Out-File $dbPath -Encoding utf8

Write-Host "Z-DIAL GENERADO: $dial [STATUS: TUNED]" -ForegroundColor Green

# 5. LANZADOR DE INTERFAZ Z-ARPA
# Buscamos procesos que tengan 'streamlit' en su comando
$serverCheck = Get-Process | Where-Object { $_.CommandLine -like "*streamlit*" }

if ($null -eq $serverCheck) {
    Write-Host "Iniciando Servidor de Auditoría Z-ARPA..." -ForegroundColor Yellow
    
    # En macOS/Linux, usamos una ejecución de fondo simple
    # El comando 'streamlit run zarpa.py' se lanza y liberamos la terminal
    $job = Start-Job -ScriptBlock { streamlit run zarpa.py }
    
    # Esperamos un momento para asegurar que no falle de inmediato
    Start-Sleep -Seconds 2
    Write-Host "Z-ARPA ONLINE: Accede a http://localhost:8501" -ForegroundColor Green
} else {
    Write-Host "Z-ARPA ya se encuentra auditando [STATUS: ACTIVE]" -ForegroundColor Gray
}