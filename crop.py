import os
import sys
from PIL import Image

def procesar_imagen(input_path, output_path, porcentaje_reduccion=50):
    """
    Reduce el tamaño dimensional de la imagen manteniendo la máxima calidad
    e información de color por píxel mediante interpolación Lanczos.
    """
    if not os.path.exists(input_path):
        print(f"❌ Error: No se encontró el archivo en {input_path}")
        return

    try:
        # Abrir la imagen original
        with Image.open(input_path) as img:
            ancho_original, alto_original = img.size
            print(f"Image original: {ancho_original}x{alto_original} px")

            # Calcular las nuevas dimensiones
            factor = porcentaje_reduccion / 100.0
            nuevo_ancho = int(ancho_original * factor)
            nuevo_alto = int(alto_original * factor)

            # Redimensionar usando LANCZOS (el estándar de alta calidad para reducción)
            img_redimensionada = img.resize((nuevo_ancho, nuevo_alto), Image.Resampling.LANCZOS)

            # Asegurar que el directorio de salida exista
            os.makedirs(os.path.dirname(output_path), exist_ok=True)

            # Guardar optimizando el archivo
            img_redimensionada.save(output_path, format="PNG", optimize=True)
            
            print("---")
            print(f"✨ ¡Proceso completado con éxito!")
            print(f"Imagen de salida: {nuevo_ancho}x{nuevo_alto} px")
            print(f"Guardada en: {output_path}")

    except Exception as e:
        print(f"❌ Ocurrió un error al procesar la imagen: {e}")

if __name__ == "__main__":
    # Rutas por defecto solicitadas
    RUTA_ENTRADA = "img/biorush.png"
    RUTA_SALIDA = "img/biorush_optimizado.png"
    
    # Puedes cambiar este porcentaje (ej. 75 para un recorte menor, 50 para la mitad)
    PORCENTAJE = 75 

    print("🤖 Iniciando optimización de imagen para BioRush...")
    procesar_imagen(RUTA_ENTRADA, RUTA_SALIDA, PORCENTAJE)