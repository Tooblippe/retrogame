"""
Retro online game player - play online games with an arduino controller 

	Author:		tobie.nortje@navitas.co.za
	My bio:		www.navitas.co.za/tobienortje
	Project:	https://github.com/Tooblippe/retrogame
	Sendkeys:	http://www.rutherfurd.net/python/sendkeys/
"""

import SendKeys			        # module to mimim key presses
import serial			        # module to handle the serial port


port = 5				#this is serial port 6
baud = 9600				#comms rate. you can change it but make sure the arduino is also set to new rate

arduino_left = 'l'                      #these are the keys arduino will send when buttons are pushed
arduino_right = 'r'

game_left = "s"                         #these keys will we send to the active windo --- or in this game the game in the browser
game_right = "k"

def Startp():			        # this little macro will start Chrome and then lauch the site
    SendKeys.SendKeys("""
        {LWIN}
        {PAUSE 1}
         Chrome.exe{SPACE} http://www.pica-pic.com/#/merry_cook/{ENTER}
        {PAUSE 10}                      
     """)

    
try:
    ser = serial.Serial(port, baud)		#start the serial comms
    Startp()				        #lauch the site

    while 1:				        #infinite loop
      
      arduino_sent = ser.readline()              #get the command
      #print val			         #print the value - for debugging just uncomment the line		
      
      if arduino_sent[0] == arduino_left : SendKeys.SendKeys(game_left)	#if the letter "l" is received send "s" to the browser
      if arduino_sent[0] == arduino_right: SendKeys.SendKeys(game_right)	#if the letter "r" is received send "k" to the browser

except:
    print "Port " + str(port)    + " could not be opened."
    print "Make sure your arduino is connected, and you selected the correct port"




