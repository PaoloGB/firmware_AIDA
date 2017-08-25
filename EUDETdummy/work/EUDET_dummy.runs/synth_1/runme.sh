#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/software/CAD/Xilinx/2016.4/SDK/2016.4/bin:/software/CAD/Xilinx/2016.4/Vivado/2016.4/ids_lite/ISE/bin/lin64:/software/CAD/Xilinx/2016.4/Vivado/2016.4/bin
else
  PATH=/software/CAD/Xilinx/2016.4/SDK/2016.4/bin:/software/CAD/Xilinx/2016.4/Vivado/2016.4/ids_lite/ISE/bin/lin64:/software/CAD/Xilinx/2016.4/Vivado/2016.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/software/CAD/Xilinx/2016.4/Vivado/2016.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/software/CAD/Xilinx/2016.4/Vivado/2016.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/users/phpgb/workspace/myFirmware/AIDA/EUDETdummy/work/EUDET_dummy.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log top_EUDET_dummy.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source top_EUDET_dummy.tcl
