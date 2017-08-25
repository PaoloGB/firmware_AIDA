-makelib ies/xil_defaultlib -sv \
  "/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies/xpm \
  "/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xbip_utils_v3_0_7 \
  "../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_pipe_v3_0_3 \
  "../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_bram18k_v3_0_3 \
  "../../../ipstatic/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/mult_gen_v12_0_12 \
  "../../../ipstatic/hdl/mult_gen_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies/axi_lite_ipif_v3_0_4 \
  "../../../ipstatic/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/tri_mode_ethernet_mac_v9_0_6 \
  "../../../ipstatic/hdl/tri_mode_ethernet_mac_v9_0_rfs.v" \
-endlib
-makelib ies/tri_mode_ethernet_mac_v9_0_6 \
  "../../../ipstatic/hdl/tri_mode_ethernet_mac_v9_0_rfs.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/common/temac_gbe_v9_rgmii_block_sync_block.v" \
  "../../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/physical/temac_gbe_v9_rgmii_rgmii_v2_0_if.v" \
  "../../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii_block.v" \
  "../../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

