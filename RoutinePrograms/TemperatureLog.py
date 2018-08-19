import pymysql
from sense_hat import SenseHat
import time

TempFile = open("/sys/class/thermal/thermal_zone0/temp", "r")
CPUInt = float(TempFile.read())
CPUTemp = str(CPUInt/1000)

#Database connection
db = pymysql.connections.Connection(host='localhost',user='pi',password='123',database='RaspberryFields')

#Cursor to carry out statements
curs = db.cursor()

#Get the current date
SD = time.strftime('%Y-%m-%d %H:%M:%S')
UT = time.strftime('%Y-%m-%d %H:%M:%S',time.gmtime())
TZ = time.strftime('%Z',time.localtime())

#Set up sensehat
S = SenseHat()

ST = str(S.get_temperature())
STH = str(S.get_temperature_from_humidity())
STP = str(S.get_temperature_from_pressure())

#Create SQL Statement
SQL = "INSERT INTO PIData\
                        (CreateTimeUTC,CreateTime,TimeZone,SystemTemp,SenseTemp,SenseTempHumidity,SenseTempPressure)\
                    VALUES\
                        ('" + UT + "','" + SD + "','" + TZ + "','" + CPUTemp + "','" + ST + "','" + STH + "','" + STP + "')"

#Try to execute the SQL, if it fails rollback
try:
    curs.execute(SQL)

    db.commit()
except:
    db.rollback()

#Other way to write a statement, using %s seems cleaner, maybe
#SQL = "SELECT * FROM PIData Where CreateTime ='" + str(SD) + "'"
#can also do execute(SQL,(VARIABLES))
#This pulls out the affected rows

db.close()
