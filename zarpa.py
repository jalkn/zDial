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
st.header("🔬 Substrate Audit: Amero Dehydration & Quality")
with st.form("lab_entry"):
    col1, col2, col3 = st.columns(3)
    with col1:
        batch_id = st.text_input("Batch ID", value=f"AMERO_{datetime.now().strftime('%m%d_%H%M')}")
        moisture_start = st.number_input("Moisture Content (%)", min_value=0.0, max_value=100.0)
    with col2:
        drying_temp = st.number_input("Drying Temp (°C)", value=35.0)
        fiber_type = st.selectbox("Fiber Orientation", ["Longitudinal", "Fragmented", "Dust"])
    with col3:
        active_dial = st.text_input("Z-Dial Resonance", help="Alphanumeric pulse from index.html")
        resonance_root = st.number_input("Daily Root", min_value=1, max_value=9)

    notes = st.text_area("Observations (Lignin state / External Contamination check)")
    
    if st.form_submit_button("Audit & Validate Batch"):
        # Quality Logic: Batch is only VALIDATED if moisture is low and root is synced
        is_valid = moisture_start < 15.0
        entry = {
            "timestamp": datetime.now().isoformat(),
            "batch_id": batch_id,
            "moisture_pct": moisture_start,
            "temp_c": drying_temp,
            "fiber": fiber_type,
            "resonance": active_dial,
            "root": resonance_root,
            "status": "VALIDATED" if is_valid else "MOISTURE_HIGH"
        }
        save_log(entry)
        st.success(f"Audit Complete: {batch_id} logged with status: {entry['status']}")

# --- Data Science: System History ---
st.divider()
db = load_data()
if db:
    st.subheader("📜 Resonance Lineage & Substrate History")
    df = pd.DataFrame(db).sort_values(by="timestamp", ascending=False)
    st.dataframe(df, use_container_width=True)