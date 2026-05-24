import os
from PIL import Image

def generate_biomesh(image_path, output_svg_path, grid_size=13):
    if not os.path.exists(image_path):
        print(f"[-] Error: No se encontró la imagen en {image_path}")
        return

    # 1. Cargar la imagen silueteada (t1.png)
    # Convertimos a 'RGBA' para evaluar el canal alfa (la transparencia que hiciste)
    img_rgba = Image.open(image_path).convert('RGBA')
    width, height = img_rgba.size
    
    # Creamos una versión en escala de grises para medir intensidades
    img_gray = img_rgba.convert('L')
    
    svg_lines = []
    svg_lines.append(f'<svg viewBox="0 0 {width} {height}" width="100%" height="auto" class="overflow-visible">')
    svg_lines.append('  <style>')
    svg_lines.append('    .land-node { transition: fill 0.3s ease, opacity 0.3s ease, filter 0.3s ease; cursor: pointer; }')
    
# === RECALIBRACIÓN ESTÉTICA: MATRIZ DE LUZ Y NÚCLEO DE MATERIA ===
    # Nodos en reposo: Blancos, limpios, integrados orgánicamente sobre el césped real
    svg_lines.append('    .node-available { fill: #ffffff; opacity: 0.70; transition: all 0.3s ease; }')
    
    # Al pasar el mouse: El nodo se transforma en negro con un sutil borde blanco para anticipar la materia
    svg_lines.append('    .land-node:hover { fill: #111111 !important; opacity: 1 !important; stroke: #ffffff; stroke-width: 1px; filter: none !important; }')
    
    # Nodo seleccionado (Pulsor del cliente): Empaque negro puro sólido, nítido y contundente (Z-Brick)
    svg_lines.append('    .node-pulsed { fill: #111111 !important; opacity: 1 !important; stroke: #ffffff; stroke-width: 1.5px; filter: none !important; }')
    svg_lines.append('  </style>')
    svg_lines.append('  <g id="bioconstruccion-mesh">')

    node_count = 0
    max_radius = grid_size / 2 * 0.95

    for y in range(0, height, grid_size):
        for x in range(0, width, grid_size):
            # Evaluamos la transparencia del píxel original
            r, g, b, alpha = img_rgba.getpixel((x, y))
            
            # FILTRO DE SILUETA DIRECTO: Si el píxel es transparente, se ignora por completo.
            # Esto elimina el marco al 100% sin importar el color del fondo.
# ... Dentro de tu bucle en dots.py ...
            if alpha < 10:
                continue
                
            pixel_gray = img_gray.getpixel((x, y))
            
            # Doble Inversión: Usamos el canal oscuro de t1.png para dar volumen
            brightness_factor = (255 - pixel_gray) / 255.0
            radius = brightness_factor * max_radius
            
            if radius < 2.5:
                continue
                
            node_count += 1
            # Forzamos la clase disponible que maneja el fill blanco puro
            node_class = "node-available"
            
            svg_lines.append(f'    <circle class="land-node {node_class}" cx="{x}" cy="{y}" r="{radius:.1f}" id="node-point-{node_count}" onclick="scrollToNodeID({node_count})" />')

    svg_lines.append('  </g>')
    svg_content = '\n'.join(svg_lines) + '\n</svg>'

    os.makedirs(os.path.dirname(output_svg_path), exist_ok=True)
    with open(output_svg_path, 'w', encoding='utf-8') as f:
        f.write(svg_content)
        
    print("\n" + "="*60)
    print("       ZENERGIA TECH-LAB // REVELADO DE LUZ COMPLETADO        ")
    print("="*60)
    print(f" [+] Nodos de luz sembrados con éxito: {node_count} PUNTOS.")
    print(f" [+] Archivo exportado a: {output_svg_path}")
    print("="*60 + "\n")

if __name__ == "__main__":
    generate_biomesh(
        image_path="img/t1.png", 
        output_svg_path="img/barranquero-mesh.svg", 
        grid_size=13  # Mantenemos 32 para una densidad estelar impecable y limpia
    )