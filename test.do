# Reading C:/altera/13.0sp1/modelsim_ase/tcl/vsim/pref.tcl 
# vsim +nowarnTSCALE -Lf test_lib -Lf modules_lib -gui -t 1ps -novopt test_lib.dig_core_tb 
# Loading sv_std.std
# Loading test_lib.dig_core_tb
# Loading modules_lib.uart_transceiver
# Loading modules_lib.dig_core
# Loading modules_lib.reg_fsm
# Loading modules_lib.reg_file
add wave -position end  sim:/dig_core_tb/clk_i
add wave -position end  sim:/dig_core_tb/rst_n_i
add wave -position end  sim:/dig_core_tb/tx_wr_i
add wave -position end  sim:/dig_core_tb/tx_data_i
add wave -position end  sim:/dig_core_tb/rx
add wave -position end  sim:/dig_core_tb/tx_done_o
add wave -position end  sim:/dig_core_tb/rx_done_o
add wave -position end  sim:/dig_core_tb/rx_data_o
add wave -position end  sim:/dig_core_tb/tx
add wave -position end  sim:/dig_core_tb/debug_o
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/clk
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/rst_n
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/rx_done_i
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/tx_done_i
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/data_i
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/reg_addr_o
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/reg_data_o
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/rd_en_o
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/wr_en_o
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/cmd_type_d
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/cmd_type_q
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/addr_d
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/addr_q
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/data_d
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/data_q
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/wr_en
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/rd_en
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/state
add wave -position end  sim:/dig_core_tb/dut/i_reg_fsm/next_state
add wave -position end  sim:/dig_core_tb/dut/i_reg_file/clk
add wave -position end  sim:/dig_core_tb/dut/i_reg_file/rst_n
add wave -position end  sim:/dig_core_tb/dut/i_reg_file/addr_i
add wave -position end  sim:/dig_core_tb/dut/i_reg_file/data_i
add wave -position end  sim:/dig_core_tb/dut/i_reg_file/wr_en_i
add wave -position end  sim:/dig_core_tb/dut/i_reg_file/data_o
add wave -position end  sim:/dig_core_tb/dut/i_reg_file/reg_addr_d
add wave -position end  sim:/dig_core_tb/dut/i_reg_file/reg_addr_q
log * -r
run 5ms
