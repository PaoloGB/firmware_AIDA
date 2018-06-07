# -*- coding: utf-8 -*-
import uhal
from I2CuHal import I2CCore
import StringIO

class SFPI2C:
    #Class to configure the EEPROM

    def __init__(self, i2c, slaveaddr=0x50):
        self.i2c = i2c
        self.slaveaddr = slaveaddr

    def readEEPROM(self, startadd, nBytes):
        #Read EEPROM memory locations
        mystop= False
        myaddr= [startadd]#0xfa
        self.i2c.write( self.slaveaddr, [startadd], mystop)
        res= self.i2c.read( self.slaveaddr, nBytes)
        return res

    def writeReg(self, regN, regContent, verbose=False):
        #Basic functionality to write to register.
        if (regN < 0) | (regN > 7):
            print "PCA9539PW - ERROR: register number should be in range [0:7]"
            return
        regContent= regContent & 0xFF
        mystop=True
        cmd= [regN, regContent]
        self.i2c.write( self.slaveaddr, cmd, mystop)

    def readReg(self, regN, nwords, verbose=False):
        #Basic functionality to read from register.
        mystop=False
        self.i2c.write( self.slaveaddr, [regN], mystop)
        res= self.i2c.read( self.slaveaddr, nwords)
        return res

    def getVendorId(self):
        """ Returns the OUI vendor id"""
        id=[0, 0, 0]
        id[0]= self.readReg(37, 1, False)[0]
        id[1]= self.readReg(38, 1, False)[0]
        id[2]= self.readReg(39, 1, False)[0]
        print id
        return id

    def getVendorPN(self):
        """ Returns the part number defined by the vendor"""
        pn=[]
        for iaddr in range(0, 16):
            item= self.readReg( 40+iaddr , 1, False)[0]
            pn.append(item)
        print pn
        return pn

    def scanI2C(self):
        mystop=True
        for iAddr in range (0, 128):
            self.i2c.write( iAddr, [], mystop)
