graph TD
    %% =========================================================================
    %% SECCIÓN 1: TOPOLOGÍA GLOBAL DEL ECOSISTEMA
    %% =========================================================================
    
    %% Achromatic / Aseptic Style Specifications (Pure Monochrome)
    classDef web fill:#000000,stroke:#ffffff,stroke-width:2px,color:#ffffff;
    classDef mobile fill:#ffffff,stroke:#000000,stroke-width:2px,color:#000000;
    classDef watch fill:#121212,stroke:#ffffff,stroke-dasharray: 5 5,stroke-width:1px,color:#ffffff;

    VAULT[JAKO VAULT DRAWER<br><i>Astro Interface Orchestrator & 5-Block Matrix</i>]
    PULSOR[PULSOR MOBILE HUD<br><i>Blocks 2, 3, 4 App Layer</i>]
    WATCH[PULSE WATCH APP<br><i>Block 2 Core Hardware: 36mm Icosahedron Grid</i>]

    VAULT <-->|Static Hydro-Islands / REST API| PULSOR
    PULSOR <-->|BLE / 10s Compressed Window Batch| WATCH

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

graph TD
    A[Pulse Watch App: Block 2 Edge Sensors] -->|Continuous Sampling: Hz + Tension| B(Local Memory Cache)
    B -->|Millisecond Loop / Base-12 Intervals| C[Pulsor Mobile App: Integrated 3-Block HUD]
    C -->|Synchronous HTTPS POST API| D[FastAPI Central Backend / Vault]
    
    D --> E{Cyclic Evaluation: 21,600 Dials / 6h}
    E -->|Sub-Second Engine| F[Millisecond-Level Mapping: Icosahedron Angular Coordinate]
    E -->|Macro-Cycle Engine| G[Historical Accumulation in Physical Space DIM]
    
