import psycopg2

def get_db():
    return psycopg2.connect(
        host="localhost",
        user="admin",
        password="admin123",
        database="patients"
    )
