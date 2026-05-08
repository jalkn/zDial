# run.ps1 - Zenergia Unified Engine | WAVE Protocol Edition
# Operator: Jalko | Node: Santa Elena

$Manifesto = @"
# 🍄 ZENERGIA.WORLD: Bio-Hardware & Bio-Construction Ecosystem
ZENERGIA orquesta la transición hacia una arquitectura regenerativa mediante la producción de materiales vivos y validación biocinética.

## 🏗️ El Ecosistema de Resonancia
1. Z-Box (Manufacturing Node): Bioreactor asíncrono IoT.
2. Z-Brick (Construction Unit): Módulos de micelio con doble cara funcional.
3. Z-Dial (Biokinetic Interface): Protocolo de validación humana WAVE.

Global Launch: Solsticio de Junio 2026 | Santa Elena, Antioquia
"@

Write-Host "Iniciando Ecosistema Zenergia con Protocolo WAVE..." -ForegroundColor Cyan

# 1. SETUP DE DIRECTORIOS (Sintaxis simplificada sin arrays para evitar ParserError)
if (!(Test-Path "data")) { New-Item -ItemType Directory -Path "data" | Out-Null }
if (!(Test-Path "img")) { New-Item -ItemType Directory -Path "img" | Out-Null }

$Manifesto | Out-File -FilePath "README.md" -Encoding utf8

# 2. GENERADOR DEL DIAL DEL DÍA
$now = Get-Date
$d = $now.Day
$m = $now.Month

# Lógica WAVE: Mayo(5)=AV, Junio(6)=WAV, Julio+(7)=WAVE
$protocol = if ($m -eq 5) { "AV" } elseif ($m -eq 6) { "WAV" } else { "WAVE" }

$sets = $m
$reps = $d * 10
$dial = "$sets$protocol$reps"

$logEntry = @"
# BITSTREAM_LOG: $($now.ToString("yyyy-MM-dd HH:mm"))
# DIAL_ACTIVE: $dial | PROTOCOL: WAVE_ENCRYPTION
[DATA] PHASE: $protocol | SETS: $sets | REPS: $reps | STATUS: SYNCED
"@

$logEntry | Out-File -FilePath "data/bitstream.log" -Append
Write-Host "[!] Z-Dial generado: $dial" -ForegroundColor Yellow

# 3. LANZAMIENTO DEL SERVIDOR
Write-Host "Servidor activo en http://localhost:8000" -ForegroundColor Green

if (Get-Command "python3" -ErrorAction SilentlyContinue) {
    python3 -m http.server 8000
} elseif (Get-Command "python" -ErrorAction SilentlyContinue) {
    python -m http.server 8000
} else {
    Write-Host "Error: No se encontró Python." -ForegroundColor Red
}