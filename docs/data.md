graph LR
    subheading[Capture & Data Ingestion Ecosystem]
    
    subgraph Hardware Tier
        W[PULSE WATCH APP]
    end

    subgraph Mobile Tier
        M[PULSOR MOBILE APP]
    end

    subgraph Cloud Vault & Database Tier
        V[JAKO VAULT WEB]
        DB1[(Table: sesiones_biocineticas)]
        DB2[(Tabla: telemetria_raw)]
    end

    W -->|Bluetooth LE / 10s Window Batch| M
    M -->|Synchronous API HTTPS POST| V
    V -->|Commit Meta Ingestion Header| DB1
    V -->|Commit Unrolled Time Series Data| DB2
    DB1 ---|Relational Association 1 to N| DB2

    style subheading fill:none,stroke:none,font-weight:bold;
    classDef default fill:#f8fafc,stroke:#64748b,stroke-width:1px;
