import matplotlib.pyplot as plt 
import database_connection as db

data = db.update_data()

hospital_names, total_count = zip(*data)

plt.figure(figsize = (14, 7))
plt.xticks(fontsize = 8)

plt.bar(hospital_names, total_count, width=0.5)

plt.show()
