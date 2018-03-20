# -*- coding: utf-8 -*-
import uhal
from I2CuHal import I2CCore
import StringIO

class PCA9539PW:
    #Class to configure the I2C multiplexer

    def __init__(self, i2c, slaveaddr=0x74):
        self.i2c = i2c
        self.slaveaddr = slaveaddr

    def setActiveChannel(self, channel, verbose=False):
        #Basic functionality to activate one channel
        # In principle multiple channels can be active at the same time but for now
        # we are not implementing this option
        if (channel < 0) | (channel > 7):
            print "PCA9539PW - ERROR: channel number should be in range [0:7]"
            return
        mystop=True
        cmd= [0x1 << channel]
        self.i2c.write( self.slaveaddr, cmd, mystop)


    def getChannelStatus(self, verbose=False):
        #Basic functionality to read the status of the control register and determine
        # which channel is currently enabled.
        mystop=False
        self.i2c.write( self.slaveaddr, [0xFF], mystop)
        res= self.i2c.read( self.slaveaddr, 1)
        return res
