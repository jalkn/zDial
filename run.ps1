# run.ps1 - Zenergia Unified Engine | Bio-Construction Edition
# Operator: Jalko | Node: Santa Elena

$Manifesto = @"
# 🍄 ZENERGIA.WORLD: Bio-Hardware & Bio-Construction Ecosystem

ZENERGIA orquesta la transición hacia una arquitectura regenerativa mediante la producción de materiales vivos y validación biocinética.

## 🏗️ El Ecosistema de Resonancia
1. **Z-Box (Manufacturing Node)**: Bioreactor asíncrono IoT (60x40) que estandariza la producción de bio-materiales y genera la "Sinfonía de Resonancia" (z-Beats).
2. **Z-Brick (Construction Unit)**: Módulos de micelio con doble cara funcional (Onda de Gota / Código Z-Dial) y certificación de origen inmutable.
3. **Z-Dial (Biokinetic Interface)**: Protocolo de validación humana (FSWS) que utiliza Realidad Aumentada para sincronizar el cuerpo con el pulso del micelio.

**Global Launch: Solsticio de Junio 2026 | Santa Elena, Antioquia**
"@

Write-Host "Iniciando Ecosistema Zenergia..." -ForegroundColor Cyan

# 1. SETUP DE DIRECTORIOS Y DOCUMENTACIÓN
$dirs = @("data", "img")
foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}
$Manifesto | Out-File -FilePath "README.md" -Encoding utf8

# 2. GENERADOR DEL DIAL DEL DÍA (Lógica Hexagonal)
$now = Get-Date
$d = $now.Day
$m = $now.Month

# Ajuste de Protocolo: Mayo (5) es FS | Junio (6) es FSS | Julio+ (7) es FSSW...
# Nota: "S" sustituye a "U" (Stand) según la nueva arquitectura.
$protocol = if ($m -eq 5) { "FS" } elseif ($m -eq 6) { "FSS" } else { "FSSW" }
$sets = $m
$reps = $d * 10
$dial = "$sets$protocol$reps"

$logEntry = @"
# BITSTREAM_LOG: $($now.ToString("yyyy-MM-dd HH:mm"))
# DIAL_ACTIVE: $dial | PHASE: RESONANCE_STABILITY
[DATA] SETS: $sets | REPS: $reps | STATUS: ACTIVE
"@

$logEntry | Out-File -FilePath "data/bitstream.log" -Append
Write-Host "[!] Dial del día generado: $dial" -ForegroundColor Yellow

# 3. LANZAMIENTO DEL SERVIDOR
Write-Host "Servidor activo en http://localhost:8000" -ForegroundColor Green

if (Get-Command "python3" -ErrorAction SilentlyContinue) {
    python3 -m http.server 8000
} elseif (Get-Command "python" -ErrorAction SilentlyContinue) {
    python -m http.server 8000
} else {
    Write-Host "Error: No se encontró Python." -ForegroundColor Red
}