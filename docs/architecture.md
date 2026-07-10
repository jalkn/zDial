graph TD
    %% =========================================================================
    %% SECCIÓN 1: TOPOLOGÍA GLOBAL DEL ECOSISTEMA
    %% =========================================================================
    
    %% Especificaciones de Estilo Acromático / Aséptico
    classDef web fill:#eff6ff,stroke:#2563eb,stroke-width:2px,color:#1e3a8a;
    classDef mobile fill:#f0fdf4,stroke:#16a34a,stroke-width:2px,color:#14532d;
    classDef watch fill:#fff7ed,stroke:#ea580c,stroke-width:2px,color:#7c2d12;

    %% Definición de Nodos de la Red
    VAULT[JAKO VAULT WEB<br><i>Astro Interface Orchestrator & GCP Target</i>]
    PULSOR[PULSOR MOBILE APP<br><i>Clean Phone HUD & Wave Render Canvas</i>]
    WATCH[PULSE WATCH APP<br><i>Edge Heart Rate Sensors & IMU Log Batching</i>]

    %% Direcciones del Flujo de Sincronización
    VAULT <-->|Cloud Sync / REST HTTPS API| PULSOR
    PULSOR <-->|Bluetooth Low Energy / 10s Batch Window| WATCH

    %% Asignación de Estilos Estructurales
    class VAULT web;
    class PULSOR mobile;
    class WATCH watch;

    %% =========================================================================
    %% SECCIÓN 2: PIPELINE DE PROCESAMIENTO DE TELEMETRÍA
    %% =========================================================================
    
    A[Pulse Watch App: Edge Sensors] -->|Continuous Sampling: Hz + Tension| B(Local Memory Cache)
    B -->|10s Compressed Batch via BLE| C[Pulsor Mobile App: Local HUD]
    C -->|Validated HTTP POST Request| D[FastAPI Central Backend]
    
    D --> E{Evaluate Timestamp Parity}
    E -->|Odd Second| F[Sub-Second Engine: Millisecond-Level Mapping]
    E -->|Even Second| G[Macro-Cycle Engine: Macro Time Blocks & Sub-Slots]
    
    F --> H[Compile Base-12 Coordinate]
    G --> H
    
    H --> I[Generate Unique Alphanumeric Signature]
    H --> J[Halftone SVG Geometry Pipeline Generation]
    
    D --> K[(Asynchronous Database Write)]
    
