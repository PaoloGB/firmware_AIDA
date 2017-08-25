-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
-- Date        : Thu Aug 17 13:46:46 2017
-- Host        : fortis.phy.bris.ac.uk running 64-bit Scientific Linux release 6.9 (Carbon)
-- Command     : write_vhdl -force -mode synth_stub
--               /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/tlu_event_fifo/tlu_event_fifo_stub.vhdl
-- Design      : tlu_event_fifo
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tlu_event_fifo is
  Port ( 
    rst : in STD_LOGIC;
    wr_clk : in STD_LOGIC;
    rd_clk : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 63 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    full : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    empty : out STD_LOGIC;
    almost_empty : out STD_LOGIC;
    rd_data_count : out STD_LOGIC_VECTOR ( 13 downto 0 );
    prog_full : out STD_LOGIC
  );

end tlu_event_fifo;

architecture stub of tlu_event_fifo is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "rst,wr_clk,rd_clk,din[63:0],wr_en,rd_en,dout[31:0],full,almost_full,empty,almost_empty,rd_data_count[13:0],prog_full";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_1_3,Vivado 2016.4";
begin
end;
