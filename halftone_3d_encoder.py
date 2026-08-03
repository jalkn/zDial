import math
import json

class Halftone3DEncoder:
    """
    Biokinetic Halftone Encoder v1.0
    Converts physical matrices into 3D spherical point clouds.
    - Macro Mode: 21,600 dots (1 Dial = 1 Particle)
    - Micro Mode: 64,800 dots (1 Dial = 3 Particle Waves)
    """
    def __init__(self, mode="macro"):
        self.mode = mode
        self.total_dots = 21600 if mode == "macro" else 64800

    def generate_spherical_halftone(self, cycle_second=0):
        """
        Calculates 3D spatial coordinates and density radii for the Sandwatch matrix.
        Maps the 6-hour cycle (21,600 seconds) to particle migration.
        """
        fill_ratio = (cycle_second % 21600) / 21600.0
        active_particles = int(fill_ratio * self.total_dots)
        matrix = []

        for i in range(self.total_dots):
            is_transferred = i < active_particles
            
            # Fibonacci sphere distribution algorithm for uniform 3D density
            phi = math.acos(1 - 2 * ((i + 0.5) / self.total_dots))
            theta = math.pi * (1 + 5**0.5) * i

            # Spatial coordinates
            radius = 1.0
            x = round(radius * math.sin(phi) * math.cos(theta), 4)
            z = round(radius * math.sin(phi) * math.sin(theta), 4)
            y = round(-1.2 if is_transferred else 1.2, 4)
            
            dot_radius = round(0.1 + (0.9 * (i / self.total_dots)), 3)

            matrix.append({
                "id": i,
                "pos": [x, y, z],
                "r": dot_radius,
                "active": 1 if is_transferred else 0
            })

        return {
            "mode": self.mode,
            "total_dots": self.total_dots,
            "cycle_second": cycle_second,
            "fill_ratio": round(fill_ratio, 4),
            "matrix": matrix
        }

if __name__ == "__main__":
    encoder = Halftone3DEncoder(mode="macro")
    data = encoder.generate_spherical_halftone(cycle_second=10800)
    print(f"✔ [3D HALFTONE ENGINE] Processed {data['total_dots']} particles successfully.")
