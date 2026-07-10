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
