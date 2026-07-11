erDiagram
    biokinetic_sessions {
        UUID session_id PK "Primary Key - Unique Identifier"
        UUID user_id "Foreign Key Reference"
        VARCHAR sphere_idx "Computed Quantum Coordinate (36mm Icosahedron Grid)"
        BIGINT start_timestamp "Session Start Epoch Timestamp"
        BIGINT end_timestamp "Session End Epoch Timestamp"
        INTEGER accumulated_dials "Total Biokinetic Units Generated (Max 21,600 per Cycle)"
        VARCHAR pulsor_variant_id "PULSOR Vector Variant ID Mapping"
    }
    
    telemetry_raw {
        BIGINT reading_id PK "Auto-incrementing Ingestion Sequence"
        UUID session_id FK "Link to Parent Biokinetic Session"
        FLOAT frequency_hz "Ingested Clock Wave Frequency Metric"
        FLOAT cellular_tension "Ingested Molecular Tensile Network Metric"
        BIGINT exact_timestamp "Precise Millisecond Occurrence Log"
    }
    
    biokinetic_sessions ||--|{ telemetry_raw : "logs"