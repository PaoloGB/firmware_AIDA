onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L xbip_utils_v3_0_7 -L xbip_pipe_v3_0_3 -L xbip_bram18k_v3_0_3 -L mult_gen_v12_0_12 -L axi_lite_ipif_v3_0_4 -L tri_mode_ethernet_mac_v9_0_6 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.temac_gbe_v9_rgmii xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {temac_gbe_v9_rgmii.udo}

run -all

quit -force
