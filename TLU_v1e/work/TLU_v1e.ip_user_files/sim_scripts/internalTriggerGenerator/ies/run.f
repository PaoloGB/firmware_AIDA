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
-makelib ies/c_reg_fd_v12_0_3 \
  "../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_dsp48_wrapper_v3_0_4 \
  "../../../ipstatic/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_pipe_v3_0_3 \
  "../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_dsp48_addsub_v3_0_3 \
  "../../../ipstatic/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_addsub_v3_0_3 \
  "../../../ipstatic/hdl/xbip_addsub_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/c_addsub_v12_0_10 \
  "../../../ipstatic/hdl/c_addsub_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies/c_gate_bit_v12_0_3 \
  "../../../ipstatic/hdl/c_gate_bit_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_counter_v3_0_3 \
  "../../../ipstatic/hdl/xbip_counter_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/c_counter_binary_v12_0_10 \
  "../../../ipstatic/hdl/c_counter_binary_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../TLU_v1e.srcs/sources_1/ip/internalTriggerGenerator/sim/internalTriggerGenerator.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

