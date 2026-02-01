#!/bin/bash
set -e

mkdir -p config data

cat > requirements.txt <<'REQ'
flask
psycopg2-binary
python-dotenv
REQ

cat > db.py <<'PY'
import psycopg2

def get_db():
    return psycopg2.connect(
        host="localhost",
        user="admin",
        password="admin123",
        database="patients"
    )
PY

cat > app.py <<'PY'
from flask import Flask, jsonify
from db import get_db

app = Flask(__name__)

@app.route("/patients")
def get_patients():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id, name, ssn, diagnosis FROM patients")
    rows = cur.fetchall()
    return jsonify(rows)

if __name__ == "__main__":
    app.run(debug=True)
PY

cat > auth.py <<'PY'
def authenticate(request):
    # TODO: implement authentication
    return True
PY

cat > logging_config.py <<'PY'
import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(message)s"
)
PY

cat > config/database.yaml <<'YAML'
database:
  host: localhost
  port: 5432
  name: patients
  encryption:
    at_rest: none
    in_transit: none
YAML

cat > data/patients.csv <<'CSV'
id,name,ssn,diagnosis
1,Jane Doe,123-45-6789,Diabetes
2,John Smith,987-65-4321,Hypertension
CSV

cat > .env.example <<'ENV'
DATABASE_URL=postgresql://user:password@host:5432/dbname
ENV

cat > README.md <<'MD'
# St. Mary's Patient API

Internal Flask API used by St. Mary's Hospital.

Authentication and security hardening are planned.
MD

echo "✅ stmarys-patient-api bootstrapped"
