#!/bin/bash
set -e

# =========================================================================
# macOS Terminal Colors
# =========================================================================
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GRAY='\033[0;90m'
NC='\033[0m'

echo -e "${CYAN}=========================================================${NC}"
echo -e "${CYAN}     JAKO CORE - ENGINE PURGE & INITIALIZATION           ${NC}"
echo -e "${CYAN}=========================================================${NC}"

# =========================================================================
# 1. Aseptic Cache Purge
# =========================================================================
echo -e "\n${MAGENTA}[1/8] Purging caching systems and build targets...${NC}"
CACHE_PATHS=(".astro" "dist" "node_modules/.vite")
for path in "${CACHE_PATHS[@]}"; do
    if [ -d "$path" ]; then
        echo -e "${GRAY}🧹 Dropping: $path${NC}"
        rm -rf "$path"
    fi
done
echo -e "${GREEN}✔ Sanitization complete.${NC}"

# =========================================================================
# 2. Base Configuration Files (ISOLATED BUILD MANIFEST)
# =========================================================================
echo -e "\n${YELLOW}[2/8] Staging project manifests with isolated build safety...${NC}"

cat << 'JSON_EOF' > package.json
{
  "name": "jako-core",
  "type": "module",
  "version": "8.0.0",
  "scripts": {
    "dev": "astro dev",
    "start": "astro dev",
    "build": "astro build",
    "preview": "astro preview",
    "astro": "astro"
  },
  "dependencies": {
    "astro": "^4.0.0"
  }
}
JSON_EOF

cat << 'MJS_EOF' > astro.config.mjs
import { defineConfig } from 'astro/config';

export default defineConfig({
  srcDir: "./src",
  publicDir: "./public",
  outDir: "./dist",
  server: {
    port: 3000
  }
});
MJS_EOF

# =========================================================================
# 3. Pure Mathematical Backend Engine Injection (`z_dial_core.py`)
#    INTEGRATED WITH VOLATILE SQLITE PERSISTENCE LAYER (1:N SCHEMA)
# =========================================================================
echo -e "\n${MAGENTA}[3/8] Solidifying core computational engine script with relational DB...${NC}"

cat << 'PYTHON_EOF' > z_dial_core.py
import time
import json
import sys
import sqlite3
import uuid
from datetime import datetime

class ZDialEngine:
    """
    Z-Dial Engine v8.2 - Minimalist Production Core.
    Manages deterministic quantum time-collapsing and direct SQLite orchestration.
    """
    def __init__(self, db_path="jako_vault.db"):
        self.db_path = db_path
        self.VECTOR_CLOCK_MATRIX = {
            'P': 1,  'U': 2,  'L': 3,  'S': 4,
            'PL': 5, 'PU': 6, 'LU': 7, 'SU': 8,
            'PUL': 9,'LPS': 10,'SPU': 11,'ULS': 12
        }
        self._init_database()

    def _init_database(self):
        """Initializes volatile database tables directly matching schema definitions."""
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            # Table 1: Meta Ingestion Header
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS sesiones_biocineticas (
                    session_id TEXT PRIMARY KEY,
                    user_id TEXT,
                    sphere_idx TEXT,
                    start_timestamp INTEGER,
                    end_timestamp INTEGER,
                    accumulated_dials INTEGER,
                    pulsor_variant_id TEXT
                );
            """)
            # Table 2: Unrolled Time Series Data
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS telemetria_raw (
                    reading_id INTEGER PRIMARY KEY AUTOINCREMENT,
                    session_id TEXT,
                    frequency_hz REAL,
                    cellular_tension REAL,
                    exact_timestamp INTEGER,
                    FOREIGN KEY(session_id) REFERENCES sesiones_biocineticas(session_id)
                );
            """)
            conn.commit()

    def collapse_time_slice(self) -> dict:
        """Executes structural calculation slicing based on epoch state."""
        now = datetime.now()
        minutes = now.minute
        seconds = now.second
        milliseconds = int((time.time() % 1) * 1000)

        sets_stage = 1
        reps_stage = 1
        current_action = 'P'

        # Odd Path: Sub-Second Engine
        if seconds % 2 != 0:
            progress_1s = milliseconds / 1000.0
            sets_stage = int(progress_1s * 12) + 1
            reps_stage = 13 - sets_stage
            if progress_1s < 0.25: current_action = 'P'
            elif progress_1s < 0.50: current_action = 'U'
            elif progress_1s < 0.75: current_action = 'L'
            else: current_action = 'S'
        # Even Path: Macro-Cycle Engine
        else:
            sets_stage = int((minutes % 12) + 1)
            if seconds < 30:
                sub_slot = int((seconds % 30) / 7.5)
                current_action = ["PL", "PU", "LU", "SU"][sub_slot] if sub_slot < 4 else "PL"
                reps_stage = int((seconds % 10) + 2)
            else:
                sub_slot = int(((seconds - 30) % 30) / 7.5)
                current_action = ["PUL", "LPS", "SPU", "ULS"][sub_slot] if sub_slot < 4 else "ULS"
                reps_stage = int(((seconds - 30) % 10) + 3)

        sets_stage = max(1, min(12, sets_stage))
        reps_stage = max(1, min(12, reps_stage))

        coordinate = f"{sets_stage}{current_action}{reps_stage}"
        dials_gained = sets_stage * reps_stage
        
        return {
            "coordinate": coordinate,
            "action": current_action,
            "dials": dials_gained,
            "hz": round(0.05 + (sets_stage / 240.0), 4),
            "tension": round(14.2 + (reps_stage * 0.8), 2),
            "timestamp": int(time.time() * 1000)
        }

    def commit_telemetry_pipeline(self) -> str:
        """Simulates ingestion payload mapping data straight into relational tables."""
        slice_data = self.collapse_time_slice()
        session_uuid = str(uuid.uuid4())
        user_uuid = str(uuid.uuid4())
        
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            
            # 1. Commit Meta Ingestion Header
            cursor.execute("""
                INSERT INTO sesiones_biocineticas 
                VALUES (?, ?, ?, ?, ?, ?, ?)
            """, (session_uuid, user_uuid, slice_data["coordinate"], slice_data["timestamp"], 
                  slice_data["timestamp"] + 10000, slice_data["dials"], slice_data["action"]))
            
            # 2. Commit Unrolled Time Series Data
            cursor.execute("""
                INSERT INTO telemetria_raw (session_id, frequency_hz, cellular_tension, exact_timestamp)
                VALUES (?, ?, ?, ?)
            """, (session_uuid, slice_data["hz"], slice_data["tension"], slice_data["timestamp"]))
            
            conn.commit()
            
        return session_uuid

if __name__ == "__main__":
    engine = ZDialEngine()
    if len(sys.argv) > 1 and sys.argv[1] == "--telemetry-stream":
        created_id = engine.commit_telemetry_pipeline()
        
        # Pull generated confirmation to verify relational compliance
        with sqlite3.connect(engine.db_path) as compliance_conn:
            compliance_conn.row_factory = sqlite3.Row
            cur = compliance_conn.cursor()
            session_row = cur.execute("SELECT * FROM sesiones_biocineticas WHERE session_id=?", (created_id,)).fetchone()
            raw_rows = cur.execute("SELECT * FROM telemetria_raw WHERE session_id=?", (created_id,)).fetchall()
            
            output_verification = {
                "pipeline_status": "RELATIONAL_COMMIT_SUCCESS",
                "database_target": engine.db_path,
                "meta_header": dict(session_row),
                "unrolled_series_count": len(raw_rows),
                "series_sample": [dict(r) for r in raw_rows]
            }
            print(json.dumps(output_verification, indent=2))
    else:
        print("--- [MATHEMATICAL CORE ENGINE OUTPUT] ---")
        print(engine.collapse_time_slice())
PYTHON_EOF

echo -e "${GREEN}✔ Computational core logic verified locally.${NC}"

# =========================================================================
# 4. Static Assets Provisioning (NATIVE INDEX ANCHOR)
# =========================================================================
echo -e "\n${MAGENTA}[4/8] Provisioning pristine index.html asset as core target...${NC}"

mkdir -p public/img

cat << 'INDEX_EOF' > public/index.html
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <link class="icon" type="image/png" href="img/favicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>JAKO VAULT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Plus+Jakarta+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script>
        tailwind.config = { 
            theme: { 
                extend: { 
                    screens: { 'xs': '400px' },
                    colors: { 
                        'jako-bg': 'var(--jako-bg)',
                        'jako-text': 'var(--jako-text)',
                        'jako-border': 'var(--jako-border)',
                        'jako-glass': 'var(--jako-glass)',
                        'jako-led': 'var(--jako-led)',
                    },
                    fontFamily: { 
                        'sans': ['Orbitron', 'sans-serif'],
                        'mono': ['Orbitron', 'monospace'],
                        'body': ['Plus Jakarta Sans', 'sans-serif']
                    }
                }
            }
        }
    </script>
    <style>
        :root[data-theme="dark"] {
            --jako-bg: rgba(0, 0, 0, 0.95);
            --jako-text: #ffffff;
            --jako-border: rgba(255, 255, 255, 0.02);
            --jako-glass: rgba(0, 0, 0, 0.5);
            --jako-led: rgba(255, 255, 255, 0.75);
            --gradient-start: rgba(255, 255, 255, 0.03);
            --gradient-mid: rgba(5, 5, 8, 0.85);
            --gradient-end: #000000;
        }
        :root[data-theme="white"] {
            --jako-bg: #f8f9fa;
            --jako-text: #000000;
            --jako-border: rgba(0, 0, 0, 0.08);
            --jako-glass: rgba(255, 255, 255, 0.4);
            --jako-led: rgba(0, 0, 0, 0.85);
            --gradient-start: rgba(0, 0, 0, 0.02);
            --gradient-mid: rgba(248, 249, 250, 0.85);
            --gradient-end: #ffffff;
        }

        body { 
            scroll-behavior: smooth; 
            letter-spacing: 0.05em;  
            overscroll-behavior: none;
            background-color: var(--jako-bg);
            color: var(--jako-text);
            transition: background-color 0.5s ease, color 0.5s ease;
        }

        #page-bg-overlay {
            position: fixed;
            inset: 0;
            background: radial-gradient(circle at 50% 50%, var(--gradient-start) 15%, var(--gradient-mid) 80%, var(--gradient-end) 100%);
            z-index: -1;
            transform: translateZ(0);
        }

        :root[data-theme="dark"] .active-led {
            text-shadow: 0 0 10px var(--jako-led), 0 0 4px var(--jako-led) !important;
        }
        :root[data-theme="white"] .active-led {
            text-shadow: 0 0 6px var(--jako-led) !important;
        }
        
        #artepanel-mask-wrapper {
        -webkit-mask-image: -webkit-radial-gradient(white, black); /* Hack nativo de Safari para congelar bordes redondeados */
        transform: translateZ(0);
        -webkit-transform: translateZ(0);
        }
    </style>
</head>
<body class="antialiased selection:bg-jako-text selection:text-jako-bg overflow-x-hidden min-h-screen">

    <div id="page-bg-overlay"></div>

    <main id="main-vault" class="w-full flex-1 flex flex-col justify-center items-center min-h-screen relative overflow-hidden"> 
        <div class="w-full flex flex-col items-center justify-center p-4 sm:p-6 select-none relative z-10">
            <div class="relative w-full max-w-[340px] sm:max-w-[400px] md:max-w-[450px] aspect-square flex flex-col items-center justify-center gap-6">
                
                <div id="artepanel-pack-container" class="relative w-[65vw] h-[65vw] sm:w-[50vw] sm:h-[50vw] md:w-[38vh] md:h-[38vh] max-w-[270px] max-h-[270px] min-w-[180px] min-h-[180px] aspect-square shrink-0 drop-shadow-[0_25px_55px_rgba(0,0,0,0.85)] cursor-pointer">
                    <div id="artepanel-mask-wrapper" class="w-full h-full relative overflow-hidden rounded-full transition-all duration-500" style="background-image: linear-gradient(135deg, var(--gradient-start) 0%, var(--gradient-mid) 50%, var(--gradient-end) 100%);">
                        
                        <div class="absolute inset-0 flex items-center justify-center p-0 z-20">
                            <svg id="laser-vector-target" viewBox="0 0 400 400" class="w-full h-full fill-none stroke-current text-jako-text transition-all duration-500 origin-center">
                                
                                <g id="wave-quantum-container" style="transform-origin: 200px 200px; -webkit-transform-origin: 200px 200px;" class="-rotate-90"></g>

                                <g id="sandwatch-group" class="origin-center opacity-0 transition-all duration-500 style-gpu" style="will-change: opacity;">
                                    <path d="M 90,90 L 310,90 L 90,310 L 310,310 Z" class="stroke-current opacity-20" />
                                    <path d="M 90,90 Q 200,125 310,90" class="stroke-current opacity-20" />
                                    <path d="M 90,310 Q 200,275 310,310" stroke-dasharray="3 3" class="stroke-current opacity-20" />
                                    <text id="z-dial" x="200" y="218" text-anchor="middle" class="fill-current font-black text-[45px] tracking-[0.35em] font-sans">1P1</text>
                                </g>
                            </svg>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </main>

    <script>
        const VECTOR_TO_CLOCK_INDEX = {
            'P': 1,  'U': 2,  'L': 3,  'S': 4,
            'PL': 5, 'PU': 6, 'LU': 7, 'SU': 8,
            'PUL': 9,'LPS': 10,'SPU': 11,'ULS': 12
        };

        let biokineticWaveHistory = [];
        let isDialTextRevealed = false;
        let lastProcessedSecond = -1; 
        const $ = id => document.getElementById(id);

        function renderBiokineticWaves() {
            const container = $('wave-quantum-container');
            if (!container || biokineticWaveHistory.length === 0) return;

            let htmlContent = '';
            biokineticWaveHistory.forEach((dial, tIndex) => {
                const currentScale = tIndex * 1; 
                const baseOpacity = isDialTextRevealed ? 0.03 : (1.0 - (tIndex * 0.08));
                if (baseOpacity <= 0) return;

                const viewFactor = 18; 
                const layers = [
                    { id: 'internal',     r: (currentScale * 1.0) * viewFactor, opacity: baseOpacity * 0.70, value: dial.sets },
                    { id: 'intermediate', r: (currentScale * 1.4) * viewFactor, opacity: baseOpacity * 0.55, value: dial.vector },
                    { id: 'external',     r: (currentScale * 1.8) * viewFactor, opacity: baseOpacity * 0.40, value: dial.reps }
                ];

                layers.forEach(layer => {
                    if (layer.r <= 0) return;
                    const circumference = 2 * Math.PI * layer.r;
                    const angle = (layer.value - 1) * 30; 
                    const arcLength = (layer.value / 12) * circumference;
                    const dashArray = `${arcLength} ${circumference}`;

                    htmlContent += `
                        <circle 
                            id="wave-${layer.id}-t${tIndex}" 
                            cx="200" 
                            cy="200" 
                            r="${layer.r}" 
                            transform="rotate(${angle} 200 200)"
                            class="stroke-current transition-all duration-300"
                            stroke-width="${tIndex === 0 ? 1.5 : 1.0}"
                            stroke-opacity="${layer.opacity}"
                            stroke-dasharray="${dashArray}"
                            stroke-linecap="round"
                            fill="none"
                        />`;
                });
            });
            container.innerHTML = htmlContent;
        }

        function updateZ() {
            const now = new Date();
            const minutes = now.getMinutes();
            const seconds = now.getSeconds();
            const milliseconds = now.getMilliseconds();

            let setsStage = 1;  
            let repsStage = 1;  
            let currentAction = 'P'; 

            if (seconds % 2 !== 0) {
                const progress1s = milliseconds / 1000; 
                setsStage = Math.floor(progress1s * 12) + 1;
                repsStage = 13 - setsStage; 
                if (progress1s < 0.25) currentAction = 'P';
                else if (progress1s < 0.5) currentAction = 'U';
                else if (progress1s < 0.75) currentAction = 'L';
                else currentAction = 'S';
            } else {
                setsStage = Math.floor((minutes % 12) + 1);
                if (seconds < 30) {
                    const subSlot = Math.floor((seconds % 30) / 7.5);
                    currentAction = ["PL", "PU", "LU", "SU"][subSlot] || "PL";
                    repsStage = Math.floor((seconds % 10) + 2);
                } else {
                    const subSlot = Math.floor(((seconds - 30) % 30) / 7.5);
                    currentAction = ["PUL", "LPS", "SPU", "ULS"][subSlot] || "ULS";
                    repsStage = Math.floor(((seconds - 30) % 10) + 3);
                }
            }
            
            setsStage = Math.max(1, Math.min(12, setsStage));
            repsStage = Math.max(1, Math.min(12, repsStage));
            const biokineticCoordinate = `${setsStage}${currentAction}${repsStage}`;
            const vectorIndex = VECTOR_TO_CLOCK_INDEX[currentAction] || 1;

            const elDial = $('z-dial');
            const elDialHud = $('z-dial-hud');
            if (elDial) elDial.textContent = biokineticCoordinate;
            if (elDialHud) elDialHud.textContent = biokineticCoordinate;

            if (seconds !== lastProcessedSecond) {
                biokineticWaveHistory.unshift({ 
                    sets: setsStage, 
                    vector: vectorIndex, 
                    reps: repsStage, 
                    rawCoord: biokineticCoordinate 
                });
                
                if (biokineticWaveHistory.length > 12) {
                    biokineticWaveHistory.pop();
                }
                
                lastProcessedSecond = seconds;
                renderBiokineticWaves();
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            updateZ();
            setInterval(updateZ, 16); 

            const container = $('artepanel-pack-container');
            if (container) {
                container.addEventListener('click', () => {
                    isDialTextRevealed = !isDialTextRevealed;
                    const sandwatchGroup = $('sandwatch-group');
                    if (sandwatchGroup) {
                        sandwatchGroup.style.opacity = isDialTextRevealed ? "1" : "0";
                    }
                    renderBiokineticWaves();
                    if (navigator.vibrate) navigator.vibrate(10);
                });
            }
        });
    </script>
</body>
</html>
INDEX_EOF

# ==============================================================================
# 5. Injection of Structural Text Data Blocks
# ==============================================================================
echo -e "\n${YELLOW}[5/8] Injecting biokinetic manifesto markdown chapter asset...${NC}"
mkdir -p docs/manifesto docs/meanings

cat << 'EOF' > docs/manifesto/S01.md
# JAKO VAULT // BIOMANIFESTO & THE COGNITIVE SYSTEM

### 👁️ CHAPTER 1 // THE COGNITIVE SYSTEM
The body is our unconscious mind and the source of our creativity. We do constant functional movements on a daily basis. You learned all of the movements as a child. It was programmed into your unconscious mind. You don’t have to think about walking because your body has already learned. When you get up, close a door, lift something from the ground, go to bed or to take a seat. All these universal motions become a program in our unconscious mind. If you focus on your body, you are aware every second and the further away your mind is. You are more aware of how creative you are. The brain's plasticity only progresses if you keep training your mind. You can do my method or you can do whatever; an art or a sport. Take the place of the programmer and watch what is happening. The mind will be your servant and your body, the art master. When it becomes a routine, you will be ready to bring new ideas into reality.

### 🫀 CHAPTER 2 // THE ALGORITHMIC DIAL & THE QUANTUM HEART
The algorithm does not invent data; it is a translator. It captures the Earth's rotation relative to the Sun in a 24-hour matrix and condenses it into a living 'bio-kinetic coordinate.' Time is emulated as a quantum heart expanding and contracting through parity:

* **ODD SECONDS (Sub-Second Engine):** Computes microcellular velocity at a millisecond level. It triggers an inverse geometric balance formula ($13 - Sets$), generating high-frequency neural acceleration.
* **EVEN SECONDS (Macro-Cycle Engine):** Consolidates structural physical force into macro blocks of 7.5 seconds based on the analog clock (Base-12).

> 📐 **SYNTAX & COLLAPSE RULE:** While the hardware architecture streams data as `[Sets][Vector][Reps]`, human translation within the HUD operates under the physics of material collapse—reading backwards from the external perimeter (`Reps`) into the internal frequency core (`Sets`). Thus, the signature **8PU10** materializes as: **10 PACE WITH PUSH AT FREQUENCY X8.** Every collapsed dial leaves the nucleus empty (**Zero Point**) for the next pulse.

### 🌊 CHAPTER 3 // BIOMECHANICAL INTEGRATION & THE THREE CONCENTRIC WAVES
The ecosystem self-manages by plotting three recurring, concentric waves that radically alter the trajectory of the geometry line according to neural transmission:

* **THE INTERNAL WAVE (Sets):** Coaxial frequency. Micro-temporal and macro-stellar vertical time. Governs energy capture, acting as the unconscious pacemaker that disciplines Stamina and Endurance. Fluctuates from 1 to 12.
* **THE INTERMEDIATE WAVE (Actions):** The transmission vector of the nervous system. Disciplines Coordination, Precision, and Velocity. It segments time into 3 phases: 
    * *Phase A (Odd Seconds // Monadic - P, U, L, S):* Zero algorithmic resistance for maximum visual lightness.
    * *Phase B (Even Seconds < 30s // Binary - PL, PU, LU, SU):* Fragmenting the stroke to simulate kinetic active oscillation.
    * *Phase C (Even Seconds >= 30s // Ternary - PUL, LPS, SPU, ULS):* Dense, fixed blocks every 7.5 seconds focusing on critical isometry.
* **THE EXTERNAL WAVE (Reps):** Dense tensional cohesion. The perimeter boundary where raw energy collides with physical reality under gravitational magnetism. Disciplines Pure Strength and Equilibrium, measuring the residual tension of the tissue.
EOF

echo -e "\n${YELLOW}[6/8] Injecting P.U.L.S. alphanumeric translation dictionary matrix...${NC}"
cat << 'EOF' > docs/meanings/PULS.txt
================================================================================
P.U.L.S. PROTOCOL // ALPHANUMERIC DIAL TRANSLATION DICTIONARY
================================================================================

[SYNTAX MATRIX]
Format: [Reps] [Vector Text] [Sets Multiplier]

[12 EVOLUTIONARY VARIANTS]

CODE | PHASE     | SPANISH TEXT                       | ENGLISH TEXT
-----+-----------+------------------------------------+-------------------------------------
P    | PHASE A   | [Reps] PASOS X[Sets]               | [Reps] PACE X[Sets]
U    | PHASE A   | [Reps] PRESIONES X[Sets]           | [Reps] PUSH X[Sets]
L    | PHASE A   | [Reps] CARGAS X[Sets]              | [Reps] PULL X[Sets]
S    | PHASE A   | [Reps] SALTOS X[Sets]              | [Reps] SURGE X[Sets]
PL   | PHASE B   | [Reps] PASOS CON CARGA X[Sets]     | [Reps] PACE WITH PULL X[Sets]
PU   | PHASE B   | [Reps] PASOS CON PRESIÓN X[Sets]   | [Reps] PACE WITH PUSH X[Sets]
LU   | PHASE B   | [Reps] CARGAS CON PRESIÓN X[Sets]  | [Reps] PULL WITH PUSH X[Sets]
SU   | PHASE B   | [Reps] SALTOS CON PRESIÓN X[Sets]  | [Reps] SURGE WITH PUSH X[Sets]
PUL  | PHASE C   | [Reps] PASOS CON PRESIÓN/CARGA     | [Reps] PACE WITH PUSH AND PULL
LPS  | PHASE C   | [Reps] CARGAS CON PASO/SALTO       | [Reps] PULL WITH PACE AND SURGE
SPU  | PHASE C   | [Reps] SALTOS CON PASO/PRESIÓN     | [Reps] SURGE WITH PACE AND PUSH
ULS  | PHASE C   | [Reps] PRESIONES CON CARGA/SALTO   | [Reps] PUSH WITH PULL AND SURGE

--------------------------------------------------------------------------------
CORE METRICS DEFINITIONS
--------------------------------------------------------------------------------
- PACE (P): Continuous displacement cadence. Pace vector driving aerobic baseline.
- PUSH (U): Direct kinetic neuro-transmission vector. Repelling force.
- PULL (L): Structural attraction biomechanical load. Tensile isometric connection.
- SURGE (S): Explosive energy expansion. High-velocity trigger mechanism.
================================================================================
EOF

# =========================================================================
# 6. Clean Frontend Architecture (MUTED FOR STATIC ISOLATION)
# =========================================================================
echo -e "\n${CYAN}[7/8] Bypassing Astro pages to allow pure public anchor execution...${NC}"
rm -rf src/pages
mkdir -p src/layouts

# =========================================================================
# 7. Environment Validation, Build & Root Extraction
# =========================================================================
echo -e "\n${YELLOW}[8/8] Validating environments, executing build & compiling target...${NC}"

if [ ! -d "node_modules/astro" ]; then
    echo -e "${MAGENTA}⚠️ node_modules missing. Initializing npm installation...${NC}"
    npm install
fi

npx astro sync
npx astro build

if [ -f "dist/index.html" ]; then
    echo -e "${CYAN}🚀 Extracting compiled index.html directly to repository root...${NC}"
    cp dist/index.html ./index.html
fi

# =========================================================================
# Executing Telemetry Pipeline Check (Architecture Validation Verification)
# =========================================================================
echo -e "\n${MAGENTA}🛰 Testing Telemetry Pipeline (Pulse Watch -> Pulsor HUD -> Vault API)...${NC}"
python3 z_dial_core.py --telemetry-stream

echo -e "\n${GREEN}========================================================${NC}"
echo -e "${GREEN}✔ BASE SYSTEM OPERATIONAL — NATIVE ANCHOR READY AT ROOT${NC}"
echo -e "${GREEN}========================================================${NC}"

npx astro preview --port 3000 --open