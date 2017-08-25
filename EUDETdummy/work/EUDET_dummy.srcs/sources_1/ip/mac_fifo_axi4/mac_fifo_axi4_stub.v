// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
// Date        : Tue Aug 22 11:55:00 2017
// Host        : fortis.phy.bris.ac.uk running 64-bit Scientific Linux release 6.9 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /users/phpgb/workspace/myFirmware/AIDA/EUDETdummy/work/EUDET_dummy.srcs/sources_1/ip/mac_fifo_axi4/mac_fifo_axi4_stub.v
// Design      : mac_fifo_axi4
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_3,Vivado 2016.4" *)
module mac_fifo_axi4(m_aclk, s_aclk, s_aresetn, s_axis_tvalid, 
  s_axis_tready, s_axis_tdata, s_axis_tlast, s_axis_tdest, s_axis_tuser, m_axis_tvalid, 
  m_axis_tready, m_axis_tdata, m_axis_tlast, m_axis_tdest, m_axis_tuser)
/* synthesis syn_black_box black_box_pad_pin="m_aclk,s_aclk,s_aresetn,s_axis_tvalid,s_axis_tready,s_axis_tdata[7:0],s_axis_tlast,s_axis_tdest[3:0],s_axis_tuser[0:0],m_axis_tvalid,m_axis_tready,m_axis_tdata[7:0],m_axis_tlast,m_axis_tdest[3:0],m_axis_tuser[0:0]" */;
  input m_aclk;
  input s_aclk;
  input s_aresetn;
  input s_axis_tvalid;
  output s_axis_tready;
  input [7:0]s_axis_tdata;
  input s_axis_tlast;
  input [3:0]s_axis_tdest;
  input [0:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [7:0]m_axis_tdata;
  output m_axis_tlast;
  output [3:0]m_axis_tdest;
  output [0:0]m_axis_tuser;
endmodule
