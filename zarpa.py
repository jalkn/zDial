import streamlit as st
import json
import os
import pandas as pd

st.set_page_config(page_title="Z-ARPA | Auditoría", page_icon="🛡️", layout="wide")

# CSS para minimalismo técnico
st.markdown("""
    <style>
    body { background-color: #0a0a0a; color: #f4f4f4; }
    .stMetric { border-bottom: 1px solid #1389d4; }
    </style>
    """, unsafe_allow_html=True)

st.title("🛡️ Z-ARPA: Bitácora de Resonancia")

def load_data():
    path = 'data/zenergia_db.json'
    if os.path.exists(path):
        with open(path, 'r') as f:
            return json.load(f)
    return []

db = load_data()

if db:
    last_log = db[-1]
    
    col1, col2, col3 = st.columns(3)
    with col1:
        st.metric("DIAL ACTIVO", last_log['dial'])
    with col2:
        st.metric("CUADRANTE", last_log['cuadrante'])
    with col3:
        st.metric("AUDITORÍA", last_log['status'])

    st.write("### 📜 Registro Histórico del Sistema")
    df = pd.DataFrame(db).sort_index(ascending=False)
    st.table(df)
else:
    st.error("Sincronización requerida. Ejecuta run.ps1 para iniciar el flujo.")