from sense_hat import SenseHat
from random import randint
from time import sleep
import datetime

S = SenseHat()

#Set Colours
R = [180,0,0]
G = [0,180,30]
B = [0,120,200]
O = [200,90,30]

#Function workout which colour should be used
def ColourCheck(XCord,YCord,CurPos):
    global R
    global G
    global B
    global O

    #Work out which colour it should be
    if  MineStr.find('[' + str(XCord+1) + ',' + str(YCord) + ']') >= 0 or \
        MineStr.find('[' + str(XCord-1) + ',' + str(YCord) + ']') >= 0 or \
        MineStr.find('[' + str(XCord) + ',' + str(YCord+1) + ']') >= 0 or \
        MineStr.find('[' + str(XCord) + ',' + str(YCord-1) + ']') >= 0 :

        if CurPos == 1:
            return(R)
        else:
            return(O)

    if CurPos == 1:
        return(G)
    else:
        return(B)

#Clear the board
S.clear(0,0,0)

#Rotate to right way round
S.set_rotation(270)

#Info message
S.show_message("Number of mines? Push to Select",0.05)

#Starting number of mines
S.show_letter("5")

MN = 5

Pushed = 0

#Loop until user pushes the middle of the joystick
while Pushed == 0:

#For each stick event, get the direction and keep the number of mines below 10
    for event in S.stick.get_events():
        if event.action == 'pressed':
            if event.direction == 'middle':
                Pushed = 1
            elif event.direction == 'up' and MN+1 < 10:
                MN = MN + 1
            elif event.direction == 'left' and MN+1 < 10:
                MN = MN + 1
            elif event.direction == 'down' and MN-1 > 0:
                MN = MN -1
            elif event.direction == 'right' and MN-1 > 0:
                MN = MN -1
            S.show_letter(str(MN))

#Clean the board
S.clear(0,0,0)

#Define starting postion
SpX = randint(1,7)
SpY = randint(1,7)

#Create a string for the mines, add in starting point so don't start on a mine
MineStr = '[' + str(SpX) + ',' + str(SpY) + '],'
MineCount = 0

#Until it gets the right number of mines
while MineCount < MN:
    MX = randint(1,7)
    MY = randint(1,7)
    #Get coordinates and put in string
    NewMine = '[' + str(MX) + ',' + str(MY) + ']'
    #If it's already there, do nothing, else allow it
    if MineStr.find(NewMine) < 0:
        MineStr = MineStr + NewMine + ','
        MineCount = MineCount + 1

#Take out the starting point as not a mine
MineStr = MineStr.replace('[' + str(SpX) + ',' + str(SpY) + '],',',')

#Colour the start
S.set_pixel(SpX,SpY,ColourCheck(SpX,SpY,1))

#Current positions
CX = SpX
CY = SpY
PX = 0
PY = 0

#Work out how many have been coloured in
ColCount = 1
ColTot = 64 - MN

#Rotate back
S.set_rotation(0)

#Start time
SD = datetime.datetime.now()
PC = 0

while ColCount < ColTot:
    for event in S.stick.get_events():
    #check if pressed
        if event.action == 'pressed' and event.direction != 'middle':
            PY = CY
            PX = CX
            #Depending on direction change the current location and increment a counter (for leaderboard)
            if event.direction == 'up':
                if CY-1 >= 0:
                    CY = CY-1
                    PC = PC + 1
            elif event.direction =='down':
                if CY+1 <= 7:
                    CY = CY+1
                    PC = PC + 1
            elif event.direction == 'right':
                if CX+1 <= 7:
                    CX = CX+1
                    PC = PC + 1
            elif event.direction =='left':
                if CX-1 >= 0:
                    CX = CX-1
                    PC = PC + 1
            #If moved
            if CX != PX or CY != PY:
                #Hit a mine
                if MineStr.find('[' + str(CX) + ',' + str(CY) + ']') >= 0:
                    S.set_rotation(270)
                    S.show_message('You Lose!',0.05,R)
                    ColCount = ColTot
                    Lose = 1
                    
                else:
                    #Get colour before change
                    if S.get_pixel(CX,CY) == [0,0,0]:
                        ColCount = ColCount+1
                    #Work out which colour it should be
                    CP = ColourCheck(CX,CY,1)
                    PP = ColourCheck(PX,PY,0)

                    S.set_pixel(CX,CY,CP)
                    S.set_pixel(PX,PY,PP)
                    Lose = 0

#If you win
if Lose!= 1:
    S.set_rotation(270)
    S.show_message('You win!',0.05,G)
    ED = datetime.datetime.now()
    S.show_message('Time take: ' + str(ED-SD),0.05,G)

sleep(5)

S.clear(0,0,0)


quit
