// Motor de Inyección Dinámica y Telemetría Unificada // ZENERGIA 2026
document.addEventListener("DOMContentLoaded", () => {
    
    // Calcular ruta relativa dinámica según la profundidad de la URL actual
    // Esto funciona perfectamente en localhost, zenergy.world/t2 o subcarpetas profundas
    const pathDepth = window.location.pathname.split('/').filter(Boolean);
    
    // Si la URL termina en /t2 o similar, pathDepth tendrá elementos, por lo que retrocedemos adecuadamente
    let prefix = "";
    if (pathDepth.length > 0 && !window.location.pathname.endsWith('index.html')) {
        // Si el último elemento es el archivo o subruta (como 't2'), dependemos del nivel relativo directo
        prefix = "";
    }
    
    // Ruta adaptativa unificada
    const basePath = "components/";

    // 1. Inyectar Barra de Navegación
    const navContainer = document.getElementById("global-nav");
    if (navContainer) {
        fetch(`${basePath}nav.html`) 
            .then(response => {
                if (!response.ok) {
                    // Intento de respaldo si falla el primer mapeo por culpa del ruteo estático
                    return fetch(`../${basePath}nav.html`);
                }
                return response;
            })
            .then(res => {
                if (!res.ok) throw new Error("Componente no encontrado en ningún nivel");
                return res.text();
            })
            .then(html => {
                navContainer.innerHTML = html;
                updateZ();
                setInterval(updateZ, 60000); 
            })
            .catch(err => console.error("[-] Error cargando nav component:", err));
    }

    // 2. Inyectar Pie de Página
    const footerContainer = document.getElementById("global-footer");
    if (footerContainer) {
        fetch(`${basePath}footer.html`) 
            .then(response => {
                if (!response.ok) {
                    // Intento de respaldo si falla el primer mapeo por culpa del ruteo estático
                    return fetch(`../${basePath}footer.html`);
                }
                return response;
            })
            .then(res => {
                if (!res.ok) throw new Error("Componente no encontrado en ningún nivel");
                return res.text();
            })
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
    window.currentGlobalHash = res; 

    // Intentar actualizar en el navbar inyectado (id="z-dial")
    const navbarDial = $("z-dial");
    if (navbarDial) {
        navbarDial.innerText = window.currentGlobalHash;
    }
    
    // Intentar actualizar en los contenedores del index si existen
    if ($('big-dial')) $('big-dial').textContent = res;
    if ($('hologram-dial')) $('hologram-dial').innerText = res;
}