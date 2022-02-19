#
# First you have to start your MySQL server then you have to edit line number 60 from this file and then run it


import pandas
import mysql.connector as con
# If you don't have the above libraries then install it first
# pip install pandas
# pip install mysql-connector-python


# The default mysql server will run on host "localhost" or "127.0.0.1" and port: 3306
def excelToMysql(excel_file_with_path,user_name,password,database_name,host="localhost",port=3306):

    # It reads excel file and converts data into python dictionary
    excel_data= pandas.read_excel(excel_file_with_path)

    # excel sheet has column names: (HOSPITAL_ID, PATIENT_ID, DISEASE, DAYS_BED_AVAILIBILITY)
    # You can access any column using: dict data['column_name']
    dict_data= excel_data.to_dict()

    # connection to database
    db = con.connect(host=host,port=port,user=user_name,password=password,database=database_name)
    obj_cur = db.cursor()

    print("------------------DATABASE OPEN----------------------")

    # The column names in my excel sheet are: (HOSPITAL_ID, PATIENT_ID, DISEASE, DAYS_BED_AVAILIBILITY)
    for i in range(len(dict_data['PATIENT_ID'])):
        
        # In my data base I have table "BEDS" with column names HOSPITAL_ID, PATIENT_ID, DISEASE, DAYS_BED_AVAILIBILITY
        # Change query as per your requirement
        db_query= f'''INSERT INTO BEDS(
            HOSPITAL_ID,PATIENT_ID, DISEASE, DAYS_BED_AVAILIBILITY
            ) 
            VALUES(
                {int(dict_data['HOSPITAL_ID'][i])},
                {int(dict_data['PATIENT_ID'][i])},
                "{dict_data['DISEASE'][i]}",
                {int(dict_data['DAYS_BED_AVAILIBILITY'][i])}
        );'''

        # It will execute the above query 
        obj_cur.execute(db_query)

        # It saves changes to the database
        db.commit()

        print("INSERTED ROW: ",i)

    # Close database
    db.close()
    print("------------------CLOSED DATABASE----------------------")


if __name__=="__main__":
    
    # For window operating system "excel_file_with_path" i.e. "D:\sheets\excel_file.xlsx"
    # For window operating system "excel_file_with_path" i.e. "/home/user/Desktop/excel_file.xlsx"
    excelToMysql("excel_file_with_path", "user_name", "password", "database_name")