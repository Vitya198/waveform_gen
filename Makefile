
all:  clean create_env create_libs comp_all run_gui 

create_env:
	mkdir -p ../libs/

create_libs:
	vlib ../libs/modules_lib
	vlib ../libs/test_lib
	vmap modules_lib ../libs/modules_lib
	vmap test_lib ../libs/test_lib
	
clean:
	rm -rf ../libs

comp_modules:
	vlog -novopt -incr -work modules_lib ../../rtl/uart_transceiver.v
	vlog -novopt -incr -work modules_lib ../../rtl/dig_core.sv
	vlog -novopt -incr -work modules_lib ../../rtl/reg_fsm.sv
	vlog -novopt -incr -work modules_lib ../../rtl/reg_file.sv
	
comp_test:
	vlog -novopt -incr -work test_lib ../tests/dig_core_tb.sv

comp_all: comp_modules comp_test
	
	
	
run:
	vsim -novopt +nowarnTSCALE -t 1ps  -Lf test_lib -Lf modules_lib test_lib.dig_core_tb
	
run_gui:
	vsim -novopt +nowarnTSCALE -t 1ps -do test.do -gui -Lf test_lib -Lf modules_lib test_lib.dig_core_tb

dload:
	cd ../..
	git init
	git pull https://github.com/Vitya198/waveform_gen

uload:
	cd ../..
	git add .
	git commit -m "update"
	git remote add origin https://github.com/Vitya198/waveform_gen
	git remote -v
	git push -u origin master 

run_sanity:
	run clean
