-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
-- Date        : Thu Aug 17 13:51:34 2017
-- Host        : fortis.phy.bris.ac.uk running 64-bit Scientific Linux release 6.9 (Carbon)
-- Command     : write_vhdl -force -mode synth_stub
--               /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/internalTriggerGenerator/internalTriggerGenerator_stub.vhdl
-- Design      : internalTriggerGenerator
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity internalTriggerGenerator is
  Port ( 
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    LOAD : in STD_LOGIC;
    L : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end internalTriggerGenerator;

architecture stub of internalTriggerGenerator is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,CE,LOAD,L[31:0],Q[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_counter_binary_v12_0_10,Vivado 2016.4";
begin
end;
