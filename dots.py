import os
from PIL import Image

def generate_biomesh(image_path, output_svg_path, grid_size=30):
    if not os.path.exists(image_path):
        print(f"[-] Error: No se encontró la imagen en {image_path}")
        return

    # 1. Cargar la imagen y forzar escala de grises (L)
    img = Image.open(image_path).convert('L')
    width, height = img.size
    
    svg_lines = []
    svg_lines.append(f'<svg viewBox="0 0 {width} {height}" width="100%" height="auto" class="overflow-visible">')
    svg_lines.append('  <style>')
    svg_lines.append('    .land-node { transition: fill 0.3s ease, opacity 0.3s ease, filter 0.3s ease; cursor: pointer; }')
    
    # === AQUÍ CONTROLAS LA OPACIDAD BASE (DURANTE EL REPOSO) ===
    # Modifica el valor de 'opacity' (0.0 a 1.0) para ajustar qué tan sutil u oscuro se ve:
    svg_lines.append('    .node-available { fill: #111111; opacity: 0.88; }')
    
    # === AQUÍ CONTROLAS EL IMPACTO CUANDO SE ACTIVA UN PULSO ===
    svg_lines.append('    .node-pulsed { fill: #ffffff !important; opacity: 1 !important; filter: drop-shadow(0 0 12px rgba(255, 255, 255, 0.9)); }')
    svg_lines.append('    .land-node:hover { fill: #ffffff !important; opacity: 1 !important; filter: drop-shadow(0 0 6px rgba(255, 255, 255, 0.6)); }')
    svg_lines.append('  </style>')
    svg_lines.append('  <g id="bioconstruccion-mesh">')

    node_count = 0
    max_radius = grid_size / 2 * 0.9  

    for y in range(0, height, grid_size):
            for x in range(0, width, grid_size):
                pixel_value = img.getpixel((x, y))
                
                # Umbral de descarte para zonas completamente blancas / fuera de silueta
                if pixel_value > 240:
                    continue
                    
                brightness_factor = (255 - pixel_value) / 255.0
                radius = brightness_factor * max_radius
                
                # Filtro de ruido para evitar puntos imperceptibles en la instalación física
                if radius < 1.5:
                    continue
                    
                node_count += 1
                node_class = "node-available"
                
                # SOLUCIÓN: Inyectamos el círculo de forma directa sin la etiqueta <a> que confunde al navegador
                svg_lines.append(f'    <circle class="land-node {node_class}" cx="{x}" cy="{y}" r="{radius:.1f}" id="node-point-{node_count}" onclick="scrollToNodeID({node_count})" />')

    

    svg_lines.append('  </g>')
    svg_lines.append('%TOTAL_NODES_MARKER%') # Marcador temporal para inyectar metadatos legibles en el SVG si es necesario
    svg_lines.append('</svg>')

    # Limpiar el marcador del SVG final para que sea un estándar limpio
    svg_content = '\n'.join(svg_lines).replace('%TOTAL_NODES_MARKER%', f'  <!-- Total Coordinated Nodes: {node_count} -->')

    os.makedirs(os.path.dirname(output_svg_path), exist_ok=True)
    with open(output_svg_path, 'w', encoding='utf-8') as f:
        f.write(svg_content)
        
    # =========================================================================
    # BLOQUE DE REPORTE TÉCNICO Y LOGÍSTICA DE BIOMASA (Z-METRICS)
    # =========================================================================
    print("\n" + "="*60)
    print("         ZENERGIA MYCELIUM TECH-LAB // INFORME DE INSTALACIÓN      ")
    print("="*60)
    print(f" [+] Matriz procesada exitosamente desde: {image_path}")
    print(f" [+] Destino del vector interactivo:      {output_svg_path}")
    print(f" [+] Dimensiones del plano virtual:       {width}px x {height}px")
    print(f" [+] Resolución de grilla biónica:        {grid_size}px")
    print("-"*60)
    print(f" [!] CANTIDAD TOTAL DE PUNTOS PLANIFICADOS: {node_count} NODOS")
    print("-"*60)
    print("  -> Equivalencia aproximada en bioconstrucción:")
    print(f"     * Bioladrillos Z-Brick vinculados (1:30):  {round(node_count / 30, 1)} unidades.")
    print(f"     * Polímeros de sustrato estimados:         {round(node_count * 0.15, 2)} kg aprox.")
    print("="*60 + "\n")

if __name__ == "__main__":
    generate_biomesh(
        image_path="img/t1.jpg", 
        output_svg_path="img/barranquero-mesh.svg", 
        grid_size=30
    )