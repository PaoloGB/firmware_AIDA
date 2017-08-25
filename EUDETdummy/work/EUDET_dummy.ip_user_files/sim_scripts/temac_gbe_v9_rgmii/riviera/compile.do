vlib work
vlib riviera

vlib riviera/xbip_utils_v3_0_7
vlib riviera/xbip_pipe_v3_0_3
vlib riviera/xbip_bram18k_v3_0_3
vlib riviera/mult_gen_v12_0_12
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/tri_mode_ethernet_mac_v9_0_6
vlib riviera/xil_defaultlib

vmap xbip_utils_v3_0_7 riviera/xbip_utils_v3_0_7
vmap xbip_pipe_v3_0_3 riviera/xbip_pipe_v3_0_3
vmap xbip_bram18k_v3_0_3 riviera/xbip_bram18k_v3_0_3
vmap mult_gen_v12_0_12 riviera/mult_gen_v12_0_12
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap tri_mode_ethernet_mac_v9_0_6 riviera/tri_mode_ethernet_mac_v9_0_6
vmap xil_defaultlib riviera/xil_defaultlib

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
"../../../../EUDET_dummy.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/common/temac_gbe_v9_rgmii_block_sync_block.v" \
"../../../../EUDET_dummy.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/physical/temac_gbe_v9_rgmii_rgmii_v2_0_if.v" \
"../../../../EUDET_dummy.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii_block.v" \
"../../../../EUDET_dummy.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii.v" \

vlog -work xil_defaultlib "glbl.v"

