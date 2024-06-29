import mysql.connector
from mysql.connector import Error

def create_connection(host_name, user_name, user_password, db_name):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password,
            database=db_name
        )
        print("Connection to MySQL DB successful")
    except Error as e:
        print(f"The error '{e}' occurred")
    
    return connection

def execute_query(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        connection.commit()
        print("Query executed successfully")
    except Error as e:
        print(f"The error '{e}' occurred")

def fetch_query(connection, query):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as e:
        print(f"The error '{e}' occurred")

def main():
    connection = create_connection("localhost", "root", "1234", "mydb")
    
    # Fetch all teams
    select_teams = "SELECT * FROM Time"
    teams = fetch_query(connection, select_teams)
    print("Teams:")
    for team in teams:
        print(team)
    
    # Fetch all pilots
    select_pilots = "SELECT * FROM Piloto"
    pilots = fetch_query(connection, select_pilots)
    print("\nPilots:")
    for pilot in pilots:
        print(pilot)
    
    # Fetch all circuits
    select_circuits = "SELECT * FROM Circuito"
    circuits = fetch_query(connection, select_circuits)
    print("\nCircuits:")
    for circuit in circuits:
        print(circuit)

if __name__ == "__main__":
    main()
