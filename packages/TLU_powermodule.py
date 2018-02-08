# -*- coding: utf-8 -*-
import uhal
from I2CuHal import I2CCore
#import StringIO
from AD5665R import AD5665R # Library for DAC
from PCA9539PW import PCA9539PW # Library for serial line expander

class PWRLED:
    #Class to configure the EEPROM

    def __init__(self, i2ccore, DACaddr=0x1C, Exp1Add= 0x76, Exp2Add= 0x77):
        print "  TLU POWERMODULE Initializing..."
        self.TLU_I2C = i2ccore
        self.pwraddr = DACaddr
        self.exp1addr= Exp1Add
        self.exp2addr= Exp2Add
        self.intRefOn= 0
        self.verbose= True
        #Map indicator color based on their position on the expanders: 0-15 are on expander 2, 16 to 31 on expander 1. One indicator is missing the blue component, hence
        #the "-1" value.
        #self.indicatorXYZ= [(1, 0, -1), (3, 2, 4), (6, 5, 7), (9, 8, 10), (12, 11, 13), (15, 14, 16), (18, 17, 19), (21, 20, 22), (24, 23, 25), (27, 26, 28), (30, 29, 31)]
        self.indicatorXYZ= [(30, 29, 31), (27, 26, 28), (24, 23, 25), (21, 20, 22), (18, 17, 19), (15, 14, 16), (12, 11, 13), (9, 8, 10), (6, 5, 7), (3, 2, 4), (1, 0, -1)]

        self.zeDAC_pwr=AD5665R(self.TLU_I2C, self.pwraddr)
        self.zeDAC_pwr.setIntRef(self.intRefOn, self.verbose)
        self.zeDAC_pwr.writeDAC(int(0), 7, self.verbose)

        self.ledExp1=PCA9539PW(self.TLU_I2C, self.exp1addr)
        self.ledExp1.setInvertReg(0, 0x00)# 0= normal, 1= inverted
        self.ledExp1.setIOReg(0, 0x00)# 0= output, 1= input
        self.ledExp1.setOutputs(0, 0xDA)# If output, set to XX

        self.ledExp1.setInvertReg(1, 0x00)# 0= normal, 1= inverted
        self.ledExp1.setIOReg(1, 0x00)# 0= output, 1= input
        self.ledExp1.setOutputs(1, 0xB6)# If output, set to XX

        self.ledExp2=PCA9539PW(self.TLU_I2C, self.exp2addr)
        self.ledExp2.setInvertReg(0, 0x00)# 0= normal, 1= inverted
        self.ledExp2.setIOReg(0, 0x00)# 0= output, 1= input
        self.ledExp2.setOutputs(0, 0x6D)# If output, set to XX

        self.ledExp2.setInvertReg(1, 0x00)# 0= normal, 1= inverted
        self.ledExp2.setIOReg(1, 0x00)# 0= output, 1= input
        self.ledExp2.setOutputs(1, 0xDB)# If output, set to XX
        print "  TLU POWERMODULE Ready"

    def test(self):
	    print "Testing the powermodule"
	    return

    def setVch(self, channel, voltage, verbose=False):
        # Note: the channel here is the DAC channel.
        # The mapping with the power module is not one-to-one
        if ((channel < 0) | (3 < channel )):
            print "PWRModule: channel should be comprised between 0 and 3"
        else:
            if (voltage < 0):
                print "PWRModule: voltage must be comprised between 0 and 1 V. Coherced to 0 V."
                voltage = 0
            if (voltage > 1):
                print "PWRModule: voltage must be comprised between 0 and 1 V. Coherced to 1 V."
                voltage = 1
            dacValue= voltage*65535
            self.zeDAC_pwr.writeDAC(int(dacValue), channel, verbose)
        return

    def setIndicatorRGB(self, indicator, RGB=[0, 0, 0], verbose=False):
        # Indicator is one of the 11 LEDs on the front panels, labeled from 0 to 10
        # RGB allows to switch on (True) or off (False) the corresponding component for that Led
        # Note that one LED only has 2 components connected
        #print self.indicatorXYZ[indicator-1][2]
        if (1 <= indicator <= 11):
            nowStatus= []
            nowStatus.extend(self.ledExp1.getOutputs(0))
            nowStatus.extend(self.ledExp1.getOutputs(1))
            nowStatus.extend(self.ledExp2.getOutputs(0))
            nowStatus.extend(self.ledExp2.getOutputs(1))
            nowWrd= 0x00000000
            nowWrd= nowWrd | nowStatus[0]
            nowWrd= nowWrd | (nowStatus[1] << 8)
            nowWrd= nowWrd | (nowStatus[2] << 16)
            nowWrd= nowWrd | (nowStatus[3] << 24)
            nextWrd= nowWrd
            for iComp in range(0,3):
                indexComp= self.indicatorXYZ[indicator-1][iComp]
                valueComp= not bool(RGB[iComp])
                nextWrd= self._set_bit(nextWrd, indexComp, int(valueComp))
                if verbose:
                    print "n=", iComp, "INDEX=", indexComp, "VALUE=", int(valueComp), "NEXTWORD=", bin(nextWrd)
            if verbose:
                print "NOW  ", bin(nowWrd)
                print "NEXT ", bin(nextWrd)
            nextStatus= [0xFF & nextWrd, 0xFF & (nextWrd >> 8), 0xFF & (nextWrd >> 16), 0xFF & (nextWrd >> 24) ]
            print "  NOW", nowStatus
            print "  NEXT ", nextStatus
            if nowStatus[0] != nextStatus[0]:
                self.ledExp1.setOutputs(0, nextStatus[0])
            if nowStatus[1] != nextStatus[1]:
                self.ledExp1.setOutputs(1, nextStatus[1])
            if nowStatus[2] != nextStatus[2]:
                self.ledExp2.setOutputs(0, nextStatus[2])
            if nowStatus[3] != nextStatus[3]:
                self.ledExp2.setOutputs(1, nextStatus[3])

        return


    def _set_bit(self, v, index, x):
        """Set the index:th bit of v to 1 if x is truthy, else to 0, and return the new value."""
        if (index == -1):
            print "  SETBIT: Index= -1 will be ignored"
        else:
            mask = 1 << index   # Compute mask, an integer with just bit 'index' set.
            v &= ~mask          # Clear the bit indicated by the mask (if x is False)
            if x:
                v |= mask         # If x was True, set the bit indicated by the mask.
        return v
        
    def allGreen(self):
	#self.setIndicatorRGB(1, [0, 1, 0])
        #self.setIndicatorRGB(2, [0, 1, 0])
        #self.setIndicatorRGB(3, [0, 1, 0])
        #self.setIndicatorRGB(4, [0, 1, 0])
        #self.setIndicatorRGB(5, [0, 1, 0])
        #self.setIndicatorRGB(6, [0, 1, 0])
        #self.setIndicatorRGB(7, [0, 1, 0])
        #self.setIndicatorRGB(8, [0, 1, 0])
        #self.setIndicatorRGB(9, [0, 1, 0])
        #self.setIndicatorRGB(10, [0, 1, 0])
        #self.setIndicatorRGB(11, [0, 1, 0])
        self.ledExp1.setOutputs(0, 218)
	self.ledExp1.setOutputs(1, 182)
	self.ledExp2.setOutputs(0, 109)
	self.ledExp2.setOutputs(1, 219)

    def allRed(self):
	self.ledExp1.setOutputs(0, 181)
	self.ledExp1.setOutputs(1, 109)
	self.ledExp2.setOutputs(0, 219)
	self.ledExp2.setOutputs(1, 182)

    def allBlue(self):
	self.ledExp1.setOutputs(0, 111)
	self.ledExp1.setOutputs(1, 219)
	self.ledExp2.setOutputs(0, 182)
	self.ledExp2.setOutputs(1, 109)
	
    def allBlack(self):
        self.ledExp1.setOutputs(0, 255)
	self.ledExp1.setOutputs(1, 255)
	self.ledExp2.setOutputs(0, 255)
	self.ledExp2.setOutputs(1, 255)
	
    def allWhite(self):
        self.ledExp1.setOutputs(0, 0)
	self.ledExp1.setOutputs(1, 0)
	self.ledExp2.setOutputs(0, 0)
	self.ledExp2.setOutputs(1, 0)
	
    def kitt(self):
	#self.allBlack()
	self.setIndicatorRGB(1, [1, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [1, 0, 0])
        self.setIndicatorRGB(2, [1, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [1, 0, 0])
        self.setIndicatorRGB(3, [1, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [1, 0, 0])
        self.setIndicatorRGB(4, [1, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [1, 0, 0])
        self.setIndicatorRGB(5, [1, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [1, 0, 0])
        self.setIndicatorRGB(5, [1, 0, 0])
        self.setIndicatorRGB(6, [1, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [1, 0, 0])
        self.setIndicatorRGB(6, [1, 0, 0])
        self.setIndicatorRGB(7, [1, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [1, 0, 0])
        self.setIndicatorRGB(7, [1, 0, 0])
        self.setIndicatorRGB(8, [1, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [1, 0, 0])
        self.setIndicatorRGB(8, [1, 0, 0])
        self.setIndicatorRGB(9, [1, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [1, 0, 0])
        self.setIndicatorRGB(9, [1, 0, 0])
        self.setIndicatorRGB(10, [1, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [1, 0, 0])
        self.setIndicatorRGB(10, [1, 0, 0])
        self.setIndicatorRGB(11, [1, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [1, 0, 0])
        self.setIndicatorRGB(11, [1, 0, 0])
        
        #mid point
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [1, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [1, 0, 0])
        self.setIndicatorRGB(11, [1, 0, 0])
        
	self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [1, 0, 0])
        self.setIndicatorRGB(10, [1, 0, 0])
        self.setIndicatorRGB(11, [1, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [1, 0, 0])
        self.setIndicatorRGB(9, [1, 0, 0])
        self.setIndicatorRGB(10, [1, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [1, 0, 0])
        self.setIndicatorRGB(8, [1, 0, 0])
        self.setIndicatorRGB(9, [1, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [1, 0, 0])
        self.setIndicatorRGB(7, [1, 0, 0])
        self.setIndicatorRGB(8, [1, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [1, 0, 0])
        self.setIndicatorRGB(6, [1, 0, 0])
        self.setIndicatorRGB(7, [1, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [1, 0, 0])
        self.setIndicatorRGB(5, [1, 0, 0])
        self.setIndicatorRGB(6, [1, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [1, 0, 0])
        self.setIndicatorRGB(5, [1, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [1, 0, 0])
        self.setIndicatorRGB(4, [1, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [0, 0, 0])
        self.setIndicatorRGB(2, [1, 0, 0])
        self.setIndicatorRGB(3, [1, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [1, 0, 0])
        self.setIndicatorRGB(2, [1, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])
        
        self.setIndicatorRGB(1, [1, 0, 0])
        self.setIndicatorRGB(2, [0, 0, 0])
        self.setIndicatorRGB(3, [0, 0, 0])
        self.setIndicatorRGB(4, [0, 0, 0])
        self.setIndicatorRGB(5, [0, 0, 0])
        self.setIndicatorRGB(6, [0, 0, 0])
        self.setIndicatorRGB(7, [0, 0, 0])
        self.setIndicatorRGB(8, [0, 0, 0])
        self.setIndicatorRGB(9, [0, 0, 0])
        self.setIndicatorRGB(10, [0, 0, 0])
        self.setIndicatorRGB(11, [0, 0, 0])