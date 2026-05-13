import streamlit as st
import json
import os
import pandas as pd
from datetime import datetime

# Technical Configuration for Scientific Rigor
st.set_page_config(page_title="Z-ARPA | Lab Auditor", page_icon="🛡️", layout="wide")

st.markdown("""
    <style>
    body { background-color: #0a0a0a; color: #f4f4f4; }
    .stMetric { border-bottom: 1px solid #3b82f6; }
    </style>
    """, unsafe_allow_html=True)

st.title("🛡️ Z-ARPA: Laboratory & Resonance Auditor")

def load_data():
    path = 'data/zenergia_db.json'
    if not os.path.exists('data'): os.makedirs('data')
    if os.path.exists(path):
        with open(path, 'r') as f: return json.load(f)
    return []

def save_log(entry):
    db = load_data()
    db.append(entry)
    with open('data/zenergia_db.json', 'w') as f:
        json.dump(db, f, indent=4)

# --- Laboratory Entry Form (Amero Technification) ---
st.header("🔬 Material Audit: Amero Dehydration")
with st.form("lab_entry"):
    col1, col2 = st.columns(2)
    with col1:
        batch_id = st.text_input("Batch ID", value=f"AMERO_{datetime.now().strftime('%m%d')}")
        moisture_start = st.number_input("Initial Moisture (%)", min_value=0.0, max_value=100.0)
    with col2:
        drying_temp = st.number_input("Drying Temp (°C)", value=35.0)
        active_dial = st.text_input("Z-Dial Resonance", help="Input the alphanumeric pulse from the frontend")

    notes = st.text_area("Lab Observations (Fiber orientation/Lignin state)")
    
    if st.form_submit_button("Audit & Validate Batch"):
        entry = {
            "timestamp": datetime.now().isoformat(),
            "batch_id": batch_id,
            "moisture_pct": moisture_start,
            "temp_c": drying_temp,
            "resonance": active_dial,
            "status": "VALIDATED" if moisture_start < 15 else "IN_PROGRESS"
        }
        save_log(entry)
        st.success(f"Audit Complete: {batch_id} registered under resonance {active_dial}")

# --- Data Science: System History ---
st.divider()
db = load_data()
if db:
    st.subheader("📜 Resonance Lineage")
    df = pd.DataFrame(db).sort_index(ascending=False)
    st.table(df)