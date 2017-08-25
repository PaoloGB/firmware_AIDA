// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
// Date        : Thu Aug 17 13:46:40 2017
// Host        : fortis.phy.bris.ac.uk running 64-bit Scientific Linux release 6.9 (Carbon)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ tlu_event_fifo_stub.v
// Design      : tlu_event_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_3,Vivado 2016.4" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, 
  almost_full, empty, almost_empty, rd_data_count, prog_full)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[63:0],wr_en,rd_en,dout[31:0],full,almost_full,empty,almost_empty,rd_data_count[13:0],prog_full" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [63:0]din;
  input wr_en;
  input rd_en;
  output [31:0]dout;
  output full;
  output almost_full;
  output empty;
  output almost_empty;
  output [13:0]rd_data_count;
  output prog_full;
endmodule
