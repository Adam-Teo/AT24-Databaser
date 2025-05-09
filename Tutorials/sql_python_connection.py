# import mysql.connector
# # print("hello world 2.0")

# connection = mysql.connector.connect(
#     # user='',
#     # password='',
#     host='localhost',
#     database='bookcase', 
#     ssl_disabled=True
    
# )
# cursor = connection.cursor()

# query = """
#     SELECT *
#     FROM shelf
# """

# cursor.execute(query)
# # End
# # connection.close()
# # cursor.close()


# import pyodbc 
# cnxn = pyodbc.connect("Driver={SQL Server Native Client 11.0};"
#                       "Server=localhost;"
#                       "Database=bookcase;"
#                       "Trusted_Connection=yes;")


# cursor = cnxn.cursor()
# cursor.execute('SELECT * FROM shelf')

# for row in cursor:
#     print('row = %r' % (row,))


import pyodbc

try:
    database_name = input('Enter a databse name to create:')
    connection = pyodbc.connect(
        'DRIVER={SQL Server};'+
        'Server=OOO;'+
        'Database=bookcase;'+
        'Trusted_Connection=True'
        )
    connection.autocommit = True
    connection.execute(f'CREATE DATABASE {database_name}')
    print("Database Creates")
except pyodbc.Error as ex:
    print("Connection failse", ex)