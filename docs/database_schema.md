erDiagram
    %% Core Biokinetic Session Manifest
    sesiones_biocineticas {
        UUID id_sesion PK "Primary Key - Global Unique Session Identifier"
        UUID id_usuario "Foreign Key - Abstract User Reference Mapping"
        VARCHAR esfera_idx "Computed Quantum Coordinate (e.g., 9P11)"
        BIGINT timestamp_inicio "Session Start Epoch Timestamp (Milliseconds)"
        BIGINT timestamp_fin "Session End Epoch Timestamp (Milliseconds)"
        VARCHAR vector_puls_predominante "Dominant Kinetic Action Profile Identifier"
        INTEGER dials_acumulados "Total Biokinetic Units Generated"
        VARCHAR variant_pulsor_id "PULSOR Vector Variant ID Mapping"
    }
    
    %% Volatile Edge Telemetry Series
    telemetria_raw {
        BIGINT id_lectura PK "Primary Key - Auto-incrementing Ingestion Sequence"
        UUID id_sesion FK "Foreign Key Link to Parent Biokinetic Session"
        FLOAT frecuencia_hz "Ingested Clock Wave Frequency Metric"
        FLOAT tension_celular "Ingested Molecular Tensile Network Metric"
        BIGINT timestamp_exacto "Precise Millisecond Occurrence Log"
    }
    
    sesiones_biocineticas ||--|{ telemetria_raw : "logs"