import pygame, sys
from pygame.locals import *

#Define the size of the grid
xgridsize = 15
ygridsize = 15
spacing = 1
#colour of the grid
colour = (255,255,255)
#how big the window is
windowwidth = 600
windowheight = 800
#spaces at the edge
edgespcaing = spacing * 5
#how big each cell will be in the grid
if windowwidth <= windowheight:
    bcons = windowwidth
else:
    bcons = windowheight-100 #need space for the letters
blocksize = (bcons-(spacing*xgridsize)-edgespcaing*2)/xgridsize
#Where to put the border
borderstart = 0
xbordersize = ((blocksize+spacing)*xgridsize)+edgespcaing*2
ybordersize = ((blocksize+spacing)*ygridsize)+edgespcaing*2
bcolour = (200,0,0)

#start pygane
pygame.init()
#set the window
window = pygame.display.set_mode((windowwidth,windowheight))
#window name
pygame.display.set_caption ('Word Board')

border = pygame.Rect(borderstart,borderstart,xbordersize,ybordersize)
pygame.draw.rect(window,bcolour,border)

#go through the size of the grid one at a time and add a cell
for y in range(ygridsize):
    for x in range(xgridsize):
        rect = pygame.Rect((x*(blocksize+spacing))+edgespcaing,(y*(blocksize+spacing))+edgespcaing,blocksize,blocksize)
        pygame.draw.rect(window,colour,rect)

#look for the quit event
while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
    pygame.display.update()
