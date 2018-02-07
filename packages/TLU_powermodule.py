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
        self.indicatorXYZ= [(1, 0, -1), (3, 2, 4), (6, 5, 7), (9, 8, 10), (12, 11, 13), (15, 14, 16), (18, 17, 19), (21, 20, 22), (24, 23, 25), (27, 26, 28), (30, 29, 31)]

        self.zeDAC_pwr=AD5665R(self.TLU_I2C, self.pwraddr)
        self.zeDAC_pwr.setIntRef(self.intRefOn, self.verbose)
        self.zeDAC_pwr.writeDAC(int(0), 7, self.verbose)

        self.ledExp1=PCA9539PW(self.TLU_I2C, self.exp1addr)
        self.ledExp1.setInvertReg(0, 0x00)# 0= normal, 1= inverted
        self.ledExp1.setIOReg(0, 0x00)# 0= output, 1= input
        self.ledExp1.setOutputs(0, 0x1F)# If output, set to XX

        self.ledExp1.setInvertReg(1, 0x00)# 0= normal, 1= inverted
        self.ledExp1.setIOReg(1, 0x00)# 0= output, 1= input
        self.ledExp1.setOutputs(1, 0x1D)# If output, set to XX

        self.ledExp2=PCA9539PW(self.TLU_I2C, self.exp2addr)
        self.ledExp2.setInvertReg(0, 0x00)# 0= normal, 1= inverted
        self.ledExp2.setIOReg(0, 0x00)# 0= output, 1= input
        self.ledExp2.setOutputs(0, 0x85)# If output, set to XX

        self.ledExp2.setInvertReg(1, 0x00)# 0= normal, 1= inverted
        self.ledExp2.setIOReg(1, 0x00)# 0= output, 1= input
        self.ledExp2.setOutputs(1, 0x3E)# If output, set to XX
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
        print self.indicatorXYZ[indicator-1]
        print self.indicatorXYZ[indicator-1][2]
        return
