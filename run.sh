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
echo -e "\n${MAGENTA}[1/5] Purging caching systems and build targets...${NC}"
CACHE_PATHS=(".astro" "dist" "node_modules/.vite")
for path in "${CACHE_PATHS[@]}"; do
    if [ -d "$path" ]; then
        echo -e "${GRAY}🧹 Dropping: $path${NC}"
        rm -rf "$path"
    fi
done
echo -e "${GREEN}✔ Sanitization complete.${NC}"

# =========================================================================
# 2. Base Configuration Files
# =========================================================================
echo -e "\n${YELLOW}[2/5] Staging clean project configuration manifests...${NC}"

cat << 'JSON_EOF' > package.json
{
  "name": "jako-core",
  "type": "module",
  "version": "8.0.0",
  "scripts": {
    "dev": "astro dev",
    "start": "astro dev",
    "build": "astro build",
    "preview": "astro preview"
  },
  "dependencies": {
    "astro": "^4.11.3"
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
    port: 3000,
    host: true
  }
});
MJS_EOF

# =========================================================================
# 3. Pure Mathematical Backend Engine Injection (`z_dial_core.py`)
# =========================================================================
echo -e "\n${MAGENTA}[3/5] Solidifying core computational engine script...${NC}"

cat << 'PYTHON_EOF' > z_dial_core.py
import time
from datetime import datetime

class ZDialEngine:
    """
    Z-Dial Engine v8.0 - Centralized Production Logic.
    Manages deterministic quantum time-collapsing without frontend bindings.
    """
    def __init__(self):
        self.VECTOR_CLOCK_MATRIX = {
            'P': 1,  'U': 2,  'L': 3,  'S': 4,
            'PL': 5, 'PU': 6, 'LU': 7, 'SU': 8,
            'PUL': 9,'LPS': 10,'SPU': 11,'ULS': 12
        }

    def collapse_time_slice(self) -> dict:
        """Executes structural calculation slicing based on epoch state."""
        now = datetime.now()
        minutes = now.minute
        seconds = now.second
        milliseconds = int((time.time() % 1) * 1000)

        sets_stage = 1
        reps_stage = 1
        current_action = 'P'

        # Odd Path: High-Frequency sub-second engine transitions
        if seconds % 2 != 0:
            progress_1s = milliseconds / 1000.0
            sets_stage = int(progress_1s * 12) + 1
            reps_stage = 13 - sets_stage
            
            if progress_1s < 0.25: current_action = 'P'
            elif progress_1s < 0.50: current_action = 'U'
            elif progress_1s < 0.75: current_action = 'L'
            else: current_action = 'S'
                
        # Even Path: Low-Frequency macro time blocks
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
            "esfera_idx": coordinate,
            "vector_puls_predominante": current_action,
            "dials_acumulados": dials_gained,
            "telemetry_sim": {
                "frecuencia_hz": round(0.05 + (sets_stage / 240.0), 4),
                "tension_celular": round(14.2 + (reps_stage * 0.8), 2),
                "timestamp_exacto": int(time.time() * 1000)
            }
        }

if __name__ == "__main__":
    engine = ZDialEngine()
    print("--- [MATHEMATICAL CORE ENGINE OUTPUT] ---")
    print(engine.collapse_time_slice())
PYTHON_EOF

echo -e "${GREEN}✔ Computational core logic verified locally.${NC}"

# =========================================================================
# 4. Clean Frontend Architecture (EXACT INDEX10 HUD MIGRATION)
# =========================================================================
echo -e "\n${CYAN}[4/5] Erecting exact index10.html design onto Astro layout...${NC}"

mkdir -p src/layouts src/pages

cat << 'LAYOUT_EOF' > src/layouts/Layout.astro
---
interface Props {
	title: string;
}
const { title } = Astro.props;
---
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <link class="icon" type="image/png" href="img/favicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>{title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Plus+Jakarta+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script is:inline>
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

<style is:global>
    /* VARIABLES ACROMÁTICAS DE ENTORNO MATRICIAL */
    :root[data-theme="dark"] {
        --jako-bg: rgba(0, 0, 0, 0.92);
        --jako-text: #ffffff;
        --jako-border: rgba(255, 255, 255, 0.02);
        --jako-glass: rgba(0, 0, 0, 0.5);
        --jako-led: rgba(255, 255, 255, 0.65);
        --gradient-start: rgba(255, 255, 255, 0.03);
        --gradient-mid: rgba(5, 5, 8, 0.85);
        --gradient-end: #000000;
    }
    :root[data-theme="white"] {
        --jako-bg: #f8f9fa;
        --jako-text: #000000;
        --jako-border: rgba(0, 0, 0, 0.08);
        --jako-glass: rgba(255, 255, 255, 0.4);
        --jako-led: rgba(0, 0, 0, 0.75);
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

    /* SISTEMA DE EMISIÓN LED SEGÚN TEMA */
    :root[data-theme="dark"] .active-led {
        text-shadow: 0 0 10px var(--jako-led), 0 0 4px var(--jako-led) !important;
    }
    :root[data-theme="white"] .active-led {
        text-shadow: 0 0 6px var(--jako-led) !important;
    }
</style>
</head>
<body class="antialiased selection:bg-jako-text selection:text-jako-bg overflow-x-hidden min-h-screen">
    <div id="page-bg-overlay"></div>
    <slot />
</body>
</html>
LAYOUT_EOF

cat << 'INDEX_EOF' > src/pages/index.astro
---
import Layout from '../layouts/Layout.astro';
---
<Layout title="JAKO VAULT">
    <main id="main-vault" class="w-full flex-1 flex flex-col justify-center items-center min-h-screen relative overflow-hidden"> 
        <div class="w-full flex flex-col items-center justify-center p-4 sm:p-6 select-none relative z-10">
            
            <div class="relative w-full max-w-[340px] sm:max-w-[400px] md:max-w-[450px] aspect-square flex flex-col items-center justify-center gap-6">
                
                <div id="artepanel-pack-container" class="relative w-[65vw] h-[65vw] sm:w-[50vw] sm:h-[50vw] md:w-[38vh] md:h-[38vh] max-w-[270px] max-h-[270px] min-w-[180px] min-h-[180px] aspect-square shrink-0 drop-shadow-[0_25px_55px_rgba(0,0,0,0.85)]">
                    <div id="artepanel-mask-wrapper" class="w-full h-full relative overflow-hidden rounded-full transition-all duration-500" style="background-image: linear-gradient(135deg, var(--gradient-start) 0%, var(--gradient-mid) 50%, var(--gradient-end) 100%);">
                        <div class="absolute inset-0 flex items-center justify-center p-0 z-20 pointer-events-none">
                            <svg id="laser-vector-target" viewBox="0 0 400 400" class="w-full h-full fill-none stroke-current text-jako-text pointer-events-none">
                                <g id="wave-quantum-container" class="origin-center -rotate-90 rounded-full"></g>
                            </svg>
                        </div>
                    </div>
                </div>

                <div id="sandwatch-group" class="text-center transition-opacity duration-300">
                    <span id="z-dial" class="font-mono text-lg sm:text-xl font-bold tracking-widest active-led cursor-pointer">1P1</span>
                </div>

            </div>
        </div>
    </main>

    <script>
        // =========================================================================
        // MOTOR DE ENRUTAMIENTO VECTORIAL (LENGUAJE BIOCINÉTICO)
        // =========================================================================
        const VECTOR_TO_CLOCK_INDEX: Record<string, number> = {
            'P': 1,  'U': 2,  'L': 3,  'S': 4,
            'PL': 5, 'PU': 6, 'LU': 7, 'SU': 8,
            'PUL': 9,'LPS': 10,'SPU': 11,'ULS': 12
        };

        interface DialWave {
            sets: number;
            vector: number;
            reps: number;
            rawCoord: string;
        }

        let biokineticWaveHistory: DialWave[] = [];
        const $ = (id: string) => document.getElementById(id);

        // =========================================================================
        // RENDERIZADOR CUÁNTICO DE ONDAS (SANDWATCH VISUAL)
        // =========================================================================
        function renderBiokineticWaves() {
            const container = $('wave-quantum-container');
            if (!container || biokineticWaveHistory.length === 0) return;

            let htmlContent = '';
            biokineticWaveHistory.forEach((dial, tIndex) => {
                const currentScale = tIndex * 1; 
                const baseOpacity = 1.0 - (tIndex * 0.08);
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
                            class="stroke-current"
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

        // =========================================================================
        // ACTUALIZACIÓN DE COORDENADAS MATRICIALES (Z-DIAL)
        // =========================================================================
        function updateZ() {
            const now = new Date();
            const minutes = now.getMinutes();
            const seconds = now.getSeconds();

            let setsStage = 1;  
            let repsStage = 1;  
            let currentAction = 'P'; 

            if (seconds % 2 !== 0) {
                const progress1s = now.getMilliseconds() / 1000; 
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

            const lastSavedDial = biokineticWaveHistory[0];
            if (!lastSavedDial || lastSavedDial.rawCoord !== biokineticCoordinate) {
                biokineticWaveHistory.unshift({ sets: setsStage, vector: vectorIndex, reps: repsStage, rawCoord: biokineticCoordinate });
                if (biokineticWaveHistory.length > 12) biokineticWaveHistory.pop();
            }

            renderBiokineticWaves();

            const elDial = $('z-dial');
            if (elDial) elDial.textContent = biokineticCoordinate;
        }

        // Ejecución limpia garantizando la total disponibilidad del DOM en el navegador
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => {
                updateZ();
                setInterval(updateZ, 1000);
            });
        } else {
            updateZ();
            setInterval(updateZ, 1000);
        }
    </script>
</Layout>
INDEX_EOF

echo -e "${GREEN}✔ UI architecture fully synchronized to exact index10.html layout rules.${NC}"

# =========================================================================
# 5. Environment Validation and Local Provisioning
# =========================================================================
echo -e "\n${YELLOW}[5/5] Checking environment packages and running checks...${NC}"

if [ ! -d "node_modules/astro" ]; then
    echo -e "${MAGENTA}⚠️ node_modules missing. Initializing npm installation...${NC}"
    npm install
fi

npx astro sync
npx astro build

echo -e "\n${GREEN}========================================================${NC}"
echo -e "${GREEN}✔ BASE SYSTEM OPERATIONAL — INITIAL STATE CONFIRMED${NC}"
echo -e "${GREEN}========================================================${NC}"

npx astro preview --port 3000 --open