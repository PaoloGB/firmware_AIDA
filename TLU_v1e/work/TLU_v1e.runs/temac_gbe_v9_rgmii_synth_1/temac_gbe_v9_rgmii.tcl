# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7a35tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.cache/wt [current_project]
set_property parent.project_path /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii.xci
set_property is_locked true [get_files /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.runs/temac_gbe_v9_rgmii_synth_1 -new_name temac_gbe_v9_rgmii -ip [get_ips temac_gbe_v9_rgmii]]

if { $cached_ip eq {} } {

synth_design -top temac_gbe_v9_rgmii -part xc7a35tcsg324-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix temac_gbe_v9_rgmii_ temac_gbe_v9_rgmii.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ temac_gbe_v9_rgmii_stub.v
 lappend ipCachedFiles temac_gbe_v9_rgmii_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ temac_gbe_v9_rgmii_stub.vhdl
 lappend ipCachedFiles temac_gbe_v9_rgmii_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ temac_gbe_v9_rgmii_sim_netlist.v
 lappend ipCachedFiles temac_gbe_v9_rgmii_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ temac_gbe_v9_rgmii_sim_netlist.vhdl
 lappend ipCachedFiles temac_gbe_v9_rgmii_sim_netlist.vhdl

 config_ip_cache -add -dcp temac_gbe_v9_rgmii.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips temac_gbe_v9_rgmii]
}

rename_ref -prefix_all temac_gbe_v9_rgmii_

write_checkpoint -force -noxdef temac_gbe_v9_rgmii.dcp

catch { report_utilization -file temac_gbe_v9_rgmii_utilization_synth.rpt -pb temac_gbe_v9_rgmii_utilization_synth.pb }

if { [catch {
  file copy -force /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.runs/temac_gbe_v9_rgmii_synth_1/temac_gbe_v9_rgmii.dcp /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.runs/temac_gbe_v9_rgmii_synth_1/temac_gbe_v9_rgmii.dcp /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.runs/temac_gbe_v9_rgmii_synth_1/temac_gbe_v9_rgmii_stub.v /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.runs/temac_gbe_v9_rgmii_synth_1/temac_gbe_v9_rgmii_stub.vhdl /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.runs/temac_gbe_v9_rgmii_synth_1/temac_gbe_v9_rgmii_sim_netlist.v /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.runs/temac_gbe_v9_rgmii_synth_1/temac_gbe_v9_rgmii_sim_netlist.vhdl /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.ip_user_files/ip/temac_gbe_v9_rgmii]} {
  catch { 
    file copy -force /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_stub.v /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.ip_user_files/ip/temac_gbe_v9_rgmii
  }
}

if {[file isdir /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.ip_user_files/ip/temac_gbe_v9_rgmii]} {
  catch { 
    file copy -force /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.srcs/sources_1/ip/temac_gbe_v9_rgmii/temac_gbe_v9_rgmii_stub.vhdl /users/phpgb/workspace/myFirmware/AIDA/TLU_v1e/work/TLU_v1e.ip_user_files/ip/temac_gbe_v9_rgmii
  }
}
