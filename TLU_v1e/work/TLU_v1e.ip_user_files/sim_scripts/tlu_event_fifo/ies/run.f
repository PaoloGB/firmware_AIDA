-makelib ies/xil_defaultlib -sv \
  "/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies/xpm \
  "/software/CAD/Xilinx/2016.4/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/fifo_generator_v13_1_3 \
  "../../../ipstatic/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies/fifo_generator_v13_1_3 \
  "../../../ipstatic/hdl/fifo_generator_v13_1_rfs.vhd" \
-endlib
-makelib ies/fifo_generator_v13_1_3 \
  "../../../ipstatic/hdl/fifo_generator_v13_1_rfs.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../TLU_v1e.srcs/sources_1/ip/tlu_event_fifo/sim/tlu_event_fifo.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

