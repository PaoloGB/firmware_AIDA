// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
// Date        : Thu Aug 17 13:51:33 2017
// Host        : fortis.phy.bris.ac.uk running 64-bit Scientific Linux release 6.9 (Carbon)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ internalTriggerGenerator_sim_netlist.v
// Design      : internalTriggerGenerator
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "internalTriggerGenerator,c_counter_binary_v12_0_10,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_10,Vivado 2016.4" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    CE,
    LOAD,
    L,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 load_intf DATA" *) input LOAD;
  (* x_interface_info = "xilinx.com:signal:data:1.0 l_intf DATA" *) input [31:0]L;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) output [31:0]Q;

  wire CE;
  wire CLK;
  wire [31:0]L;
  wire LOAD;
  wire [31:0]Q;
  wire NLW_U0_THRESH0_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_COUNT_BY = "1" *) 
  (* C_COUNT_MODE = "1" *) 
  (* C_COUNT_TO = "1" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_LOAD = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_HAS_THRESH0 = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_LATENCY = "2" *) 
  (* C_LOAD_LOW = "0" *) 
  (* C_RESTRICT_COUNT = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_THRESH0_VALUE = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_counter_binary_v12_0_10 U0
       (.CE(CE),
        .CLK(CLK),
        .L(L),
        .LOAD(LOAD),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_U0_THRESH0_UNCONNECTED),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "1" *) (* C_COUNT_TO = "1" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "1" *) (* C_HAS_LOAD = "1" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "0" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "2" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "0" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "32" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* downgradeipidentifiedwarnings = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_counter_binary_v12_0_10
   (CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    UP,
    LOAD,
    L,
    THRESH0,
    Q);
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  input UP;
  input LOAD;
  input [31:0]L;
  output THRESH0;
  output [31:0]Q;

  wire \<const1> ;
  wire CE;
  wire CLK;
  wire [31:0]L;
  wire LOAD;
  wire [31:0]Q;
  wire NLW_i_synth_THRESH0_UNCONNECTED;

  assign THRESH0 = \<const1> ;
  VCC VCC
       (.P(\<const1> ));
  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_COUNT_BY = "1" *) 
  (* C_COUNT_MODE = "1" *) 
  (* C_COUNT_TO = "1" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_LOAD = "1" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_HAS_THRESH0 = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_LATENCY = "2" *) 
  (* C_LOAD_LOW = "0" *) 
  (* C_RESTRICT_COUNT = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_THRESH0_VALUE = "1" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "32" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_counter_binary_v12_0_10_viv i_synth
       (.CE(CE),
        .CLK(CLK),
        .L(L),
        .LOAD(LOAD),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_i_synth_THRESH0_UNCONNECTED),
        .UP(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
IrPZT8sJrL4gwcjQ4A7teFTXVZWRVdh6UPM07RVq2FwKwc+JevJgbPZljTLdm83pMI2QQQ+tLnQS
MbZ4Fj9kXA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Xjxc1YFxqqOuRTtcFqb+Qgvi25msCPqB6MteWaomj+1IvhcHL1FqbAcJWhlLpfCxY3h7wM3hUDY1
gZ2GDMJBja7ize2rh09vjUmfwtb/L7c5Le+uxWN9tGTn29dr7Fb/HPAy9YHaq+l6KW2vcmVs5bqa
6AOIAzYCRlgjSVh5+iI=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
W2iY0mEtVej8CRvsjx6juNRjA5oabilHWdENH/ObJyTPEdBkw3WcUoFAo9mS2TONllZEXxXMkV/R
zYZ4+NnzEszGToGUuIXO2rePS9KG/qYLYu+ocaB06pGEbm0pjNbicrGYgBpEZk9/CQzvLtc1ZKmH
KUoF1kGwUDDZaLV3Y7E=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vL2hyj8rfykj77F8iyedkPIoRj8bPGcmwT5sViu6QFIDomMfa+enezpWdeIqg7mtV2lxIXHXWQq2
Nif9EUYSdjEeOm7U/2F8YfjHbXWW4pAbYcPDz0wufebhfByqTrUi29TU4Pzms2No1SyBHK7N7Y7E
xTO7KtlKA2I8v8JoeidD9uPPu84yVRn6BnNYirinE6U+pz63fA/5VkxmDmlitEA7mC1eqTaWmrMj
l9wFVPNJkFb1mFr3owpjLSyOOjnN2w8w1pjZQd4vZU5zkOu+5IjxH9dzt+hPrV9lag6492CSVIMp
Bo99fE/TOBzrmayw/vTIsFnumymv0VGKzSZ/tw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j7tcHAfXlfVr8K10yq5dUrOoTCQlDTOVF01bkmcT0VV31eCSJJD6TxC2OfocSSIPlKK2h+JU5tTw
qPnDzSoVe71M+ZVvyFqoo25ZJpANMae6fwNU211yi848qfxH8dnlRh3MQPipG1c/5l2co14Squ3Q
lzU/jsNFRh4tyKL/oXsudAOpQrXlfDnPXS4UyeE8zD5+Vcrmm/x80V13XrGo9heXGuG02DN6WYQ2
+c2IeUxs+A937VV9Rsf0Dis20A+MYUDq1mJDFLFE1/pv+T9TbpGe/W1Yz7iNeY/jhqMZan/3I3kJ
phnt3cfQOwp0BWZfxDaVKifSzUzdIbCbsVoHrw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lIy7ekoWNfLu2R6GSV4TVNNFD+3yG0n8BmtMDh9u2RcNnvhiFlh5PoPDzKQOKPOqv4dkap866r1O
vtFI+lDmRoh+upItF6oMoraiP4kiKqmqmD/LTaoM7EsledaleDytecQPq+pVHdS/ehmk+Vf66AbO
DPCGr2MQU1mLXFFvTSmVlrawNyg77P889HpOZQ0fBsIGOCJb7hL7YVW4dm/YA7RVCHg0PE7O7PZl
Yy7KsFsVlppe/MZ8b1eNnIYe2D9icFE2UeKPZILe9rv8tEE24VfJ9cHKK3VOAUeurDya19EDR59b
40zNwO++e9S0RNyGWHyFvnYNLkgaXC18mzJ92g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
ahfbf2Qymn69cZRfuDCws0hG6bgDG2f9a8Wjid0iJGQ+aiXsNimRMZwDd/H3z8kdharfcQXcrhVO
Db86jVdClonK5Q/pEyiXnwB6mVp7fBIXdOWZHhv6/TE6TDj/goMs0S9lvcLhxv/UvaR7SDfzfqft
4pd7mn1Mq3nDuPe3JsjKqiE5mSxpEhjyHOuPluEvPIOXYup/yc6YszP1we1a1B71O5DkqMNROmBt
PkFAKUmjPOdB5jhoynOewLs8o3RK9Ym3grEVvLHTygoUqOXcp+vsmXF6iXqC2zXWnQiZvIkVmLDe
n/m36Zj2lmdkv2u4v3V15x6OT8stroAKOz57iA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
exlf5oIYe5sFQ+xo8260gA/Dz+lkCjNMpe+I72TYHR4Cv+xTK+c2imL5IhtONRAinpr6Sdu9QJWF
stHMUYCJUzHHX4ebBMxgn+YO+8c/DQ3yWHLko5mzVQHeaX81tuXekCsdXbuCbV02EmU7YLKu3M+v
sAh1JPzq1r/jzz6TROmOKqwjM2J35IpU39RVBOLaYKRExfZW1JzmhIQ1GsaogSf4ECQR1utS6rmR
b9tJCrsfX6Hs6TPDHDTQwwD9p+m+Q+gSYKu++q0Oqz3aNCn5JbzO79Hn6ujVkB6Nh1kO2O1SzyZ9
wdmBQl68E65ZDqmhrqP/+qeC4WkPaE9NLH3x9Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 35856)
`pragma protect data_block
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
B0QF
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
