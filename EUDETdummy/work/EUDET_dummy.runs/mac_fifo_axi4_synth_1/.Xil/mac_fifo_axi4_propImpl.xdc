set_property SRC_FILE_INFO {cfile:/users/phpgb/workspace/myFirmware/AIDA/EUDETdummy/work/EUDET_dummy.srcs/sources_1/ip/mac_fifo_axi4/mac_fifo_axi4/mac_fifo_axi4_clocks.xdc rfile:../../../EUDET_dummy.srcs/sources_1/ip/mac_fifo_axi4/mac_fifo_axi4/mac_fifo_axi4_clocks.xdc id:1 order:LATE scoped_inst:U0} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:64 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*rd_pntr_gc_reg[*]] -to [get_cells inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].wr_stg_inst/Q_reg_reg[*]] -datapath_only [get_property -min PERIOD [get_clocks -of_objects [get_ports m_aclk]]]
set_property src_info {type:SCOPED_XDC file:1 line:67 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*wr_pntr_gc_reg[*]] -to [get_cells inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].rd_stg_inst/Q_reg_reg[*]] -datapath_only [get_property -min PERIOD [get_clocks -of_objects [get_ports s_aclk]]]
current_instance U0
set_property src_info {type:SCOPED_XDC file:1 line:65 export:INPUT save:INPUT read:READ} [current_design]
set_bus_skew -from [get_cells {inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*rd_pntr_gc_reg[*]}] -to [get_cells {inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].wr_stg_inst/Q_reg_reg[*]}] 10.000
set_property src_info {type:SCOPED_XDC file:1 line:68 export:INPUT save:INPUT read:READ} [current_design]
set_bus_skew -from [get_cells {inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*wr_pntr_gc_reg[*]}] -to [get_cells {inst_fifo_gen/gaxis_fifo.gaxisf.axisf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].rd_stg_inst/Q_reg_reg[*]}] 10.000
