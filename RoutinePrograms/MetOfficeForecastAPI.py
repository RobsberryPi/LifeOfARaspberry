import requests
import xml.etree.ElementTree as ET
import pymysql
import time

#Connect to database#get the password for the database
PILogin = open("/home/pi/PILogin","r")
PIUser = str(PILogin.readline())
PIPassword = str(PILogin.readline())

PIUser = PIUser.strip()
PIPassword = PIPassword.strip()

PILogin.close

#Database connection
db = pymysql.connections.Connection(host='localhost',user=PIUser,password=PIPassword,database='RaspberryFields')
curs = db.cursor()

#Base URL
BU = "http://datapoint.metoffice.gov.uk/public/data/"

#Data page?
DP = "val/wxfcs/all/xml/351446?res=3hourly&key="

#Retrive the key for the API
curs.execute("SELECT APIKey From APIKeys WHERE Site = 'MetOffice'")
AK = str(curs.fetchone())
AK = AK.replace("(","")
AK = AK.replace(")","")
AK = AK.replace("'","")
AK = AK.replace(",","")
AK = AK.replace(" ","")

URL = BU + DP + AK

#Pull the data through
r = requests.get(url = URL)

#pull it into something workable
root = ET.fromstring(r.content)

#Current Date
SD = time.strftime('%Y-%m-%d %H:%M:%S')

#Refresh Reference data
RefRefresh = 1

#There is some reference data (some is manual), set the above to 1 to refresh it
if RefRefresh == 1:

    SQL = "DELETE FROM WeatherDataTypeRef WHERE DataType = 'Forecast'"
    #Wipe out current referrance data
    curs.execute(SQL)

    #loop through the param element and find all the different bits    
    for FType in root.iter('Param'):
        FullTypeName = ''.join(FType.itertext())
        Units = FType.attrib['units']
        ShortName = FType.attrib['name']
    
        SQL = "INSERT INTO WeatherDataTypeRef\
                                            (\
                                            WeatherType\
                                            ,Units\
                                            ,Abreviation\
                                            ,DataType\
                                            )\
                                    Values  (\
                                            '" + FullTypeName +"'\
                                            ,'" + Units + "'\
                                            ,'" + ShortName +"'\
                                            ,'Forecast'\
                                            )"
        curs.execute(SQL)
    db.commit()

#No need to re-declare this bit so do it once
SQLStart = "INSERT INTO WeatherForecast\
                                        (\
                                        ForecastTime\
                                        ,ForecastCode\
                                        ,ForecastValue\
                                        ,CreateTime\
                                        )\
                                    Values"

SQLDelStart = "DELETE FROM WeatherForecast Where ForecastTime = "

#End of reference Refresh

#Data insert, find each period
for A in root.iter('Period'):

    #Find each report within the period and work out the time
    for B in A.iter('Rep'):
        ForecastTime = A.attrib['value'][:10] + ' ' + str(int(int(B.text)/60))+':00:00'
        SQLDel = "'" + ForecastTime + "'"
        #This is removing data to avoid overlaps
        curs.execute(SQLDelStart + SQLDel)

        #Go through each attribute, easier than writing individually and more flexible for future                
        for C in B.attrib:
            SQLValues = "('" + ForecastTime + "','" + C + "','" + B.attrib[C] + "','" + SD + "')"
            curs.execute(SQLStart+SQLValues)

db.commit()
        
