// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
// Date        : Thu Aug 17 13:51:32 2017
// Host        : fortis.phy.bris.ac.uk running 64-bit Scientific Linux release 6.9 (Carbon)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ internalTriggerGenerator_stub.v
// Design      : internalTriggerGenerator
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_counter_binary_v12_0_10,Vivado 2016.4" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(CLK, CE, LOAD, L, Q)
/* synthesis syn_black_box black_box_pad_pin="CLK,CE,LOAD,L[31:0],Q[31:0]" */;
  input CLK;
  input CE;
  input LOAD;
  input [31:0]L;
  output [31:0]Q;
endmodule
