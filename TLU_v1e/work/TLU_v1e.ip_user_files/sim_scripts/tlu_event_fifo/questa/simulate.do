onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib tlu_event_fifo_opt

do {wave.do}

view wave
view structure
view signals

do {tlu_event_fifo.udo}

run -all

quit -force
