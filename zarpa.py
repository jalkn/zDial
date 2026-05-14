import streamlit as st
import json
import os
import pandas as pd
from datetime import datetime

# Technical Configuration
st.set_page_config(page_title="Z-ARPA | Lab Auditor", page_icon="🛡️", layout="wide")

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

st.title("🛡️ Z-ARPA: Laboratory & Resonance Auditor")

st.header("🔬 Substrate Audit: Amero Technification")
with st.form("lab_entry"):
    col1, col2, col3 = st.columns(3)
    with col1:
        batch_id = st.text_input("Batch ID", value=f"AMERO_{datetime.now().strftime('%m%d_%H%M')}")
        source = st.text_input("Material Source", help="Where was this amero recycled from?")
        wet_weight = st.number_input("Initial Wet Weight (g)", min_value=0.0)
    with col2:
        moisture_start = st.number_input("Initial Moisture (%)", min_value=0.0)
        fiber_type = st.selectbox("Fiber Orientation", ["Longitudinal", "Fragmented", "Dust"])
        dry_weight = st.number_input("Final Dry Weight (g)", min_value=0.0, help="Fill this after the drying cycle")
    with col3:
        active_dial = st.text_input("Z-Dial Resonance")
        resonance_root = st.number_input("Daily Root", min_value=1, max_value=9)
        drying_temp = st.number_input("Drying Temp (°C)", value=35.0)

    uploaded_file = st.file_uploader("Attach Substrate Photo", type=['jpg', 'jpeg', 'png'])
    notes = st.text_area("Observations (Lignin state / Ambient Humidity / Color)")
    
    if st.form_submit_button("Audit & Validate Batch"):
        img_path = f"data/img/{batch_id}.jpg" if uploaded_file else "None"
        if uploaded_file:
            if not os.path.exists('data/img'): os.makedirs('data/img')
            with open(img_path, "wb") as f: f.write(uploaded_file.getbuffer())

        entry = {
            "timestamp": datetime.now().isoformat(),
            "batch_id": batch_id,
            "source": source,
            "wet_weight_g": wet_weight,
            "dry_weight_g": dry_weight,
            "moisture_pct": moisture_start,
            "temp_c": drying_temp,
            "fiber": fiber_type,
            "resonance": active_dial,
            "root": resonance_root,
            "image_ref": img_path,
            "status": "DRY_VALIDATED" if dry_weight > 0 and moisture_start < 15.0 else "DEHYDRATING"
        }
        save_log(entry)
        st.success(f"Audit Complete: {batch_id} logged. Status: {entry['status']}")

# System History
db = load_data()
if db:
    st.subheader("📜 Resonance Lineage & Substrate History")
    st.dataframe(pd.DataFrame(db).sort_values(by="timestamp", ascending=False), use_container_width=True)