from flask import Flask, jsonify
from db import get_db

app = Flask(__name__)

@app.route("/patients")
def get_patients():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id, name, diagnosis FROM patients")
    rows = cur.fetchall()
    return jsonify(rows)

if __name__ == "__main__":
    app.run(debug=True)