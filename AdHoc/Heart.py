from sense_hat import SenseHat
from time import sleep

S = SenseHat()

#Set Colours
R = [180,0,0]
C = [0,0,0]
P = [255,105,180]
D = [255,20,147]

#Clear the Roard
S.clear(0,0,0)

S.set_rotation(270)

S.low_light = True

S.show_message('Happy Birthday Shreya!',0.08,P)

Heart = [
        C, R, R, C, C, R, R, C,
        R, P, P, R, R, P, P, R,
        R, P, D, P, P, D, P, R,
        R, P, D, D, D, D, P, R,
        R, P, D, D, D, D, P, R,
        C, R, P, D, D, P, R, C,
        C, C, R, P, P, R, C, C,
        C, C, C, R, R, C, C, C
        ]

InnerHeart = [
        C, C, C, C, C, C, C, C,
        C, C, C, C, C, C, C, C,
        C, C, D, C, C, D, C, C,
        C, C, D, D, D, D, C, C,
        C, C, D, D, D, D, C, C,
        C, C, C, D, D, C, C, C,
        C, C, C, C, C, C, C, C,
        C, C, C, C, C, C, C, C
        ]

MiddleHeart = [
        C, C, C, C, C, C, C, C,
        C, P, P, C, C, P, P, C,
        C, P, D, P, P, D, P, C,
        C, P, D, D, D, D, P, C,
        C, P, D, D, D, D, P, C,
        C, C, P, D, D, P, C, C,
        C, C, C, P, P, C, C, C,
        C, C, C, C, C, C, C, C
        ]
WaitTime = 0.2

A = 0

while A < 5:

    S.set_pixels(InnerHeart)

    sleep(WaitTime)

    S.set_pixels(MiddleHeart)

    sleep(WaitTime)

    S.set_pixels(Heart)

    sleep(WaitTime)

    S.set_pixels(MiddleHeart)

    sleep(WaitTime)

    S.set_pixels(InnerHeart)

    sleep(WaitTime)
    
    A = A + 1

S.set_pixels(MiddleHeart)

sleep(WaitTime)

S.set_pixels(Heart)

S.low_light = False
