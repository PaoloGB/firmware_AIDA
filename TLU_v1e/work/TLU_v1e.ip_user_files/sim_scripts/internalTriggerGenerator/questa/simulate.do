onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib internalTriggerGenerator_opt

do {wave.do}

view wave
view structure
view signals

do {internalTriggerGenerator.udo}

run -all

quit -force
