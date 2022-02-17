import pandas
import sqlite3


if __name__=="__main__":
  

    # read excel data and convert it to python dict
    
    excel_data= pandas.read_excel('hospitaldata.xlsx')
    dict_data= excel_data.to_dict()
    
    
    # connect database (database name: Hospital_DB) 
    
    db = sqlite3.connect('Hospital_DB.sqlite')
    obj_cur = db.cursor()
    
    
    # loop to excecute insertion queries for db
    
    print("------------------start----------------------")

    for i in range(len(dict_data['DAYS'])):
      
        # Table BUD has 4 columns HOSPITAL_ID, DISEASE, DAYS_BED_AVAILIBILITY and another column PATIENT ID which is set to autoincrement mood
        
        db_query= f'''INSERT INTO BEDS(
            HOSPITAL_ID, DISEASE, DAYS_BED_AVAILIBILITY
            ) 
            VALUES(
                {int(dict_data['HOSPITAL_ID'][i])},
                "{dict_data['DISEASE'][i]}",
                {int(dict_data['DAYS'][i])}
        );'''
        print("------------------data stored----------------------",i)
        
        # excecute above query and save it to db
        
        obj_cur.execute(db_query)
        db.commit()

    db.close()
    print("------------------end----------------------")


    


