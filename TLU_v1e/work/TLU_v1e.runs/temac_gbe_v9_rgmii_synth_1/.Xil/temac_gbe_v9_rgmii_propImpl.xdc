set_property SRC_FILE_INFO {cfile:/users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii.xdc rfile:../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property SRC_FILE_INFO {cfile:/users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii_clocks.xdc rfile:../../../TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/synth/temac_gbe_v9_rgmii_clocks.xdc id:2 order:LATE scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:64 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells {temac_gbe_v9_rgmii_core/flow/rx_pause/pause*to_tx_reg[*]}] -to [get_cells {temac_gbe_v9_rgmii_core/flow/tx_pause/count_set*reg}] 32 -datapath_only
set_property src_info {type:SCOPED_XDC file:1 line:65 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells {temac_gbe_v9_rgmii_core/flow/rx_pause/pause*to_tx_reg[*]}] -to [get_cells {temac_gbe_v9_rgmii_core/flow/tx_pause/pause_count*reg[*]}] 32 -datapath_only
set_property src_info {type:SCOPED_XDC file:1 line:66 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells {temac_gbe_v9_rgmii_core/flow/rx_pause/pause_req_to_tx_int_reg}] -to [get_cells {temac_gbe_v9_rgmii_core/flow/tx_pause/sync_good_rx/data_sync_reg0}] 6 -datapath_only
set_property src_info {type:SCOPED_XDC file:2 line:43 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -rise_from [get_clocks inst_rgmii_rx_clk] -rise_to [get_clocks -of_objects [get_ports rgmii_rxc]] -hold
set_property src_info {type:SCOPED_XDC file:2 line:44 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -fall_from [get_clocks inst_rgmii_rx_clk] -fall_to [get_clocks -of_objects [get_ports rgmii_rxc]] -hold
set_property src_info {type:SCOPED_XDC file:2 line:58 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -rise_from [get_clocks -of_objects [get_ports gtx_clk]] -rise_to [get_clocks inst_rgmii_tx_clk] -hold
set_property src_info {type:SCOPED_XDC file:2 line:59 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -fall_from [get_clocks -of_objects [get_ports gtx_clk]] -fall_to [get_clocks inst_rgmii_tx_clk] -hold
