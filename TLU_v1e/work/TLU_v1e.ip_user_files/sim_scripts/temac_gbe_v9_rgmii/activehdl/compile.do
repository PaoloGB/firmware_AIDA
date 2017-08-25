vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/xbip_utils_v3_0_7
vlib activehdl/xbip_pipe_v3_0_3
vlib activehdl/xbip_bram18k_v3_0_3
vlib activehdl/mult_gen_v12_0_12
vlib activehdl/axi_lite_ipif_v3_0_4
vlib activehdl/tri_mode_ethernet_mac_v9_0_6

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap xbip_utils_v3_0_7 activehdl/xbip_utils_v3_0_7
vmap xbip_pipe_v3_0_3 activehdl/xbip_pipe_v3_0_3
vmap xbip_bram18k_v3_0_3 activehdl/xbip_bram18k_v3_0_3
vmap mult_gen_v12_0_12 activehdl/mult_gen_v12_0_12
vmap axi_lite_ipif_v3_0_4 activehdl/axi_lite_ipif_v3_0_4
vmap tri_mode_ethernet_mac_v9_0_6 activehdl/tri_mode_ethernet_mac_v9_0_6

vlog -work xil_defaultlib  -sv2k12 \
"/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_7 -93 \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_3 -93 \
"../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work xbip_bram18k_v3_0_3 -93 \
"../../../ipstatic/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_12 -93 \
"../../../ipstatic/hdl/mult_gen_v12_0_vh_rfs.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../ipstatic/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vlog -work tri_mode_ethernet_mac_v9_0_6  -v2k5 \
"../../../ipstatic/hdl/tri_mode_ethernet_mac_v9_0_rfs.v" \

vcom -work tri_mode_ethernet_mac_v9_0_6 -93 \
"../../../ipstatic/hdl/tri_mode_ethernet_mac_v9_0_rfs.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/common/temac_gbe_v9_rgmii_block_sync_block.v" \
"../../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/physical/temac_gbe_v9_rgmii_rgmii_v2_0_if.v" \
"../../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii_block.v" \
"../../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii.v" \

vlog -work xil_defaultlib "glbl.v"

