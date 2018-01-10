# -*- coding: utf-8 -*-
import uhal
from I2CuHal import I2CCore
import StringIO

class CFA632:
    #Class to configure the EEPROM

    def __init__(self, i2c, slaveaddr=0x2A):
        self.i2c = i2c
        self.slaveaddr = slaveaddr

    def test(self):
	print "Testing the display"
	return
    
    def writeSomething(self, i2ccmd):
	mystop= True
	print "Write random stuff"
	print i2ccmd
	#myaddr= [int(i2ccmd)]
	self.i2c.write( self.slaveaddr, i2ccmd, mystop)
	
	return
