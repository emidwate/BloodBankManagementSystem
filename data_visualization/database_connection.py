import mysql.connector

def update_data(): # wrapped in a function so that the data is updated whenever the database changes
  db = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "password", # enter here password you set for the root user on your computer
    database = "bbms"
  )

  cursor = db.cursor()

  cursor.execute("""SELECT hospital_name, count(transfusion_id) as counter
                FROM blood_transfusion bt
                INNER JOIN hospital h
                ON bt.hospital_id = h.hospital_id
                GROUP BY h.hospital_name
                ORDER BY count(transfusion_id);""") 

  # cursor.execute("""SELECT facility_name, count(transfusion_id) as counter
  #               FROM blood_transfusion bt
  #               INNER JOIN private_facility pf
  #               ON bt.private_facility_id = pf.facility_id
  #               GROUP BY pf.facility_name
  #               ORDER BY count(transfusion_id);""")

  # You can use this commented query also to see transfusions that have taken place in private facilities, just remember to comment on the above query after after you delete the comment from this one

  result = cursor.fetchall()

  query_result = []

  for row in result:
    query_result.append(list(row))
  
  return query_result

update_data()
