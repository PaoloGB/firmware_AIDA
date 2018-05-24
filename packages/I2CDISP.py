# -*- coding: utf-8 -*-
import uhal
from I2CuHal2 import I2CCore
import StringIO

class CFA632:
    #Class to configure the CFA632 display

    def __init__(self, i2c, slaveaddr=0x2A):
        self.i2c = i2c
        self.slaveaddr = slaveaddr

    def test(self):
        print "Testing the display"
        return
    
    def writeSomething(self, i2ccmd):
        mystop= True
        print "Write to CFA632"
        print "\t", i2ccmd
        #myaddr= [int(i2ccmd)]
        self.i2c.write( self.slaveaddr, i2ccmd, mystop)
	return
	
class LCD09052:
    #Class to configure the LCD09052 display

    def __init__(self, i2c, slaveaddr=0x3A):
        self.i2c = i2c
        self.slaveaddr = slaveaddr

    def test(self):
        print "Testing the display"
        return
        
    def setBrightness(self, value= 250):
        if value < 0:
            print "setBrightness: minimum value= 0. Coherced to 0"
            value = 0
        if value > 250:
            print "setBrightness: maximum value= 250. Coherced to 250"
            value = 250
        i2ccmd= [7, value]
        mystop= True
        self.i2c.write( self.slaveaddr, i2ccmd, mystop)
    
    def writeSomething(self, i2ccmd):
        mystop= True
        print "Write to LCD09052"
        print "\t", i2ccmd
        #myaddr= [int(i2ccmd)]
        self.i2c.write( self.slaveaddr, i2ccmd, mystop)
	return

