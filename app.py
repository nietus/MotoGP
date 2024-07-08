import streamlit as st
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
        st.session_state['connection'] = connection
        st.session_state['connected'] = True
        st.success("Connection to MySQL DB successful")
    except Error as e:
        st.error(f"The error '{e}' occurred")
    
    return connection

def fetch_query(connection, query):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as e:
        st.error(f"The error '{e}' occurred")

def execute_query(connection, query, data):
    cursor = connection.cursor()
    try:
        cursor.execute(query, data)
        connection.commit()
        st.success("Query executed successfully")
    except Error as e:
        st.error(f"The error '{e}' occurred")

def get_rider_names(connection):
    query = "SELECT idPiloto, Nome FROM Piloto"
    results = fetch_query(connection, query)
    return {name: id for id, name in results}

def get_race_ids(connection):
    query = "SELECT idCorrida, Data FROM Corrida"
    results = fetch_query(connection, query)
    return {str(date): id for id, date in results}

def main():
    st.set_page_config(page_title="MotoGP DB", page_icon="🏍️", layout="wide")
    
    st.title("MotoGP DB")
    st.image("https://th.bing.com/th/id/R.f95844d566c601b7dffc809e3a866645?rik=DtJkGGIHz74jaA&riu=http%3a%2f%2ftutorialaplikasi.com%2fwp-content%2fuploads%2f2016%2f10%2fMotogp.jpg&ehk=dScMjJ1ew8%2bg1t76aCg6eUfZ18QjisTeoTCYApIOLa4%3d&risl=&pid=ImgRaw&r=0", width=200)


    st.sidebar.title("Database Connection")
    host = st.sidebar.text_input("Host", "localhost", key="host")
    user = st.sidebar.text_input("User", "root", key="user")
    password = st.sidebar.text_input("Password", type="password", key="password")
    database = st.sidebar.text_input("Database", "mydb", key="database")
    
    if 'connected' not in st.session_state:
        st.session_state['connected'] = False
    
    if not st.session_state['connected']:
        if st.sidebar.button("Connect", key="connect"):
            create_connection(host, user, password, database)
    if st.session_state['connected']:
        connection = st.session_state['connection']
        st.sidebar.title("Options")
        tables = [
            "Teams", "Riders", "Mechanics", "Circuits", "Races", "Seasons", 
            "Classifications", "Users", "Favorites", "Comments", "Sponsors", "Sponsorships"
        ]
        selected_table = st.sidebar.selectbox("Select Table", tables, key="selected_table")

        if selected_table:
            st.subheader(f"{selected_table}")
            if selected_table == "Teams":
                query = "SELECT * FROM Time"
            elif selected_table == "Riders":
                query = "SELECT * FROM Piloto"
            elif selected_table == "Mechanics":
                query = "SELECT * FROM Mecanico"
            elif selected_table == "Circuits":
                query = "SELECT * FROM Circuito"
            elif selected_table == "Races":
                query = "SELECT * FROM Corrida"
            elif selected_table == "Seasons":
                query = "SELECT * FROM Temporada"
            elif selected_table == "Classifications":
                query = "SELECT * FROM Classificacao"
            elif selected_table == "Users":
                query = "SELECT * FROM AppUser"
            elif selected_table == "Favorites":
                query = "SELECT * FROM Favorito"
            elif selected_table == "Comments":
                query = "SELECT * FROM Comentario"
            elif selected_table == "Sponsors":
                query = "SELECT * FROM Patrocinador"
            elif selected_table == "Sponsorships":
                query = "SELECT * FROM Patrocinio"

            results = fetch_query(connection, query)
            if results:
                for result in results:
                    st.write(result)
            else:
                st.write(f"No {selected_table.lower()} found.")
            
            st.subheader(f"Add New {selected_table[:-1]}")
            if selected_table == "Teams":
                name = st.text_input("Name", key="team_name")
                country = st.text_input("Country", key="team_country")
                if st.button("Add Team", key="add_team_btn"):
                    query = "INSERT INTO Time (Nome, Pais) VALUES (%s, %s)"
                    execute_query(connection, query, (name, country))
            elif selected_table == "Riders":
                name = st.text_input("Name", key="rider_name")
                country = st.text_input("Country", key="rider_country")
                team = st.text_input("Team", key="rider_team")
                if st.button("Add Rider", key="add_rider_btn"):
                    query = "INSERT INTO Piloto (Nome, Pais, Time_Nome) VALUES (%s, %s, %s)"
                    execute_query(connection, query, (name, country, team))
            elif selected_table == "Mechanics":
                name = st.text_input("Name", key="mechanic_name")
                specialty = st.text_input("Specialty", key="mechanic_specialty")
                team = st.text_input("Team", key="mechanic_team")
                if st.button("Add Mechanic", key="add_mechanic_btn"):
                    query = "INSERT INTO Mecanico (Nome, Especialidade, Time_Nome) VALUES (%s, %s, %s)"
                    execute_query(connection, query, (name, specialty, team))
            elif selected_table == "Circuits":
                name = st.text_input("Name", key="circuit_name")
                country = st.text_input("Country", key="circuit_country")
                length = st.number_input("Length (km)", min_value=0.0, format="%.2f", key="circuit_length")
                if st.button("Add Circuit", key="add_circuit_btn"):
                    query = "INSERT INTO Circuito (Nome, Pais, Comprimento) VALUES (%s, %s, %s)"
                    execute_query(connection, query, (name, country, length))
            elif selected_table == "Races":
                date = st.date_input("Date", key="race_date")
                circuit_id = st.number_input("Circuit ID", min_value=1, key="race_circuit_id")
                if st.button("Add Race", key="add_race_btn"):
                    query = "INSERT INTO Corrida (Data, Circuito_idCircuito) VALUES (%s, %s)"
                    execute_query(connection, query, (date, circuit_id))
            elif selected_table == "Seasons":
                year = st.number_input("Year", min_value=1900, max_value=2100, key="season_year")
                if st.button("Add Season", key="add_season_btn"):
                    query = "INSERT INTO Temporada (Ano) VALUES (%s)"
                    execute_query(connection, query, (year,))
            elif selected_table == "Classifications":
                points = st.number_input("Points", min_value=0, key="classification_points")
                rider_names = get_rider_names(connection)
                rider_name = st.selectbox("Rider", list(rider_names.keys()), key="classification_rider_name")
                rider_id = rider_names[rider_name]
                season_year = st.number_input("Season Year", min_value=1900, max_value=2100, key="classification_season_year")
                race_ids = get_race_ids(connection)
                race_date = st.selectbox("Race Date", list(race_ids.keys()), key="classification_race_date")
                race_id = race_ids[race_date]
                if st.button("Add Classification", key="add_classification_btn"):
                    query = "INSERT INTO Classificacao (Pontos, Piloto_idPiloto, Temporada_Ano, Corrida_idCorrida) VALUES (%s, %s, %s, %s)"
                    execute_query(connection, query, (points, rider_id, season_year, race_id))
            elif selected_table == "Users":
                username = st.text_input("Username", key="user_username")
                email = st.text_input("Email", key="user_email")
                password = st.text_input("Password", type="password", key="user_password")
                if st.button("Add User", key="add_user_btn"):
                    query = "INSERT INTO AppUser (Usuario, Email, Senha) VALUES (%s, %s, %s)"
                    execute_query(connection, query, (username, email, password))
            elif selected_table == "Favorites":
                user_email = st.text_input("User Email", key="favorite_user_email")
                rider_names = get_rider_names(connection)
                rider_name = st.selectbox("Rider", list(rider_names.keys()), key="favorite_rider_name")
                rider_id = rider_names[rider_name]
                team_name = st.text_input("Team Name", key="favorite_team_name")
                if st.button("Add Favorite", key="add_favorite_btn"):
                    query = "INSERT INTO Favorito (AppUser_Email, Piloto_idPiloto, Piloto_Time_Nome) VALUES (%s, %s, %s)"
                    execute_query(connection, query, (user_email, rider_id, team_name))
            elif selected_table == "Comments":
                user_email = st.text_input("User Email", key="comment_user_email")
                text = st.text_area("Text", key="comment_text")
                race_ids = get_race_ids(connection)
                race_date = st.selectbox("Race Date", list(race_ids.keys()), key="comment_race_date")
                race_id = race_ids[race_date]
                if st.button("Add Comment", key="add_comment_btn"):
                    query = "INSERT INTO Comentario (AppUser_Email, Texto, Corrida_idCorrida) VALUES (%s, %s, %s)"
                    execute_query(connection, query, (user_email, text, race_id))
            elif selected_table == "Sponsors":
                name = st.text_input("Name", key="sponsor_name")
                country = st.text_input("Country", key="sponsor_country")
                if st.button("Add Sponsor", key="add_sponsor_btn"):
                    query = "INSERT INTO Patrocinador (Nome, Pais) VALUES (%s, %s)"
                    execute_query(connection, query, (name, country))
            elif selected_table == "Sponsorships":
                sponsor_name = st.text_input("Sponsor Name", key="sponsorship_sponsor_name")
                team_name = st.text_input("Team Name", key="sponsorship_team_name")
                if st.button("Add Sponsorship", key="add_sponsorship_btn"):
                    query = "INSERT INTO Patrocinio (Patrocinador_Nome, Time_Nome) VALUES (%s, %s)"
                    execute_query(connection, query, (sponsor_name, team_name))

if __name__ == "__main__":
    main()
