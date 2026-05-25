// Motor de Inyección Dinámica y Telemetría Unificada // ZENERGIA 2026
document.addEventListener("DOMContentLoaded", () => {
    
    // 1. Inyectar Barra de Navegación (Ruta local directa sin barra inicial)
    const navContainer = document.getElementById("global-nav");
    if (navContainer) {
        fetch("components/nav.html") 
            .then(response => response.text())
            .then(html => {
                navContainer.innerHTML = html;
                updateZ();
                setInterval(updateZ, 60000); 
            })
            .catch(err => console.error("[-] Error cargando nav component:", err));
    }

    // 2. Inyectar Pie de Página (Ruta local directa sin barra inicial)
    const footerContainer = document.getElementById("global-footer");
    if (footerContainer) {
        fetch("components/footer.html") 
            .then(response => response.text())
            .then(html => {
                footerContainer.innerHTML = html;
            })
            .catch(err => console.error("[-] Error cargando footer component:", err));
    }
});

/**
* Z-Dial Resonance Engine v8.8 - Solar Drift Matrix & PULS Protocol Sync
*/
const PHI = 1.618033;
const $ = (id) => document.getElementById(id);

// Declaramos la variable en el scope global de la ventana para blindar t2.html
window.currentGlobalHash = "INIT";

function updateZ() {
    const now = new Date();
    
    // Deriva Solar Absoluta (0° a 359.9°)
    const deg = (now.getHours() * 15) + (now.getMinutes() * 0.25);
    
    // Mapeo PULS Protocol
    let f, translation;
    if (deg >= 0 && deg < 180) { 
        f = 'PL'; 
        translation = 'pace // lift';
    } else if (deg >= 180 && deg < 270) { 
        f = 'ULS'; 
        translation = 'under // lift // surge';
    } else { 
        f = 'UP'; 
        translation = 'under // pace';
    }

    const s = Math.floor(((now.getMinutes() + 1) * PHI) % (f.length > 2 ? 6 : 9)) || 2;
    let reps = Math.floor((Math.abs(180 - deg) % 18) + 6); 

    const res = `${s}${f}${reps}`;
    window.currentGlobalHash = res; // <--- Sincronización blindada global

    const hashElement = $("header-dial-hash");
    if (hashElement) {
        hashElement.innerText = `Z_DIAL: #${window.currentGlobalHash}`;
    }
}