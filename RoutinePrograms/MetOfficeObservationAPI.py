import requests
import xml.etree.ElementTree as ET
import pymysql
import time

#get the password for the database
PILogin = open("/home/pi/PILogin","r")
PIUser = str(PILogin.readline())
PIPassword = str(PILogin.readline())

PIUser = PIUser.strip()
PIPassword = PIPassword.strip()

PILogin.close

#Database connection
db = pymysql.connections.Connection(host='localhost',user=PIUser,password=PIPassword,database='RaspberryFields')
curs = db.cursor()

#Retrive the key for the API
AK = curs.execute("SELECT APIKey From APIKeys WHERE Site = 'MetOffice'")

#Base URL
BU = "http://datapoint.metoffice.gov.uk/public/data/"

#Data page?
DP = "val/wxobs/all/xml/3344??&"

URL = BU + DP + AK

#Pull the data through
r = requests.get(url = URL)

#pull it into something workable
root = ET.fromstring(r.content)
