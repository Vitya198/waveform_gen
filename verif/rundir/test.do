onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider REG_FSM
add wave -noupdate /dig_core_tb/dut/i_reg_fsm/clk
add wave -noupdate /dig_core_tb/dut/i_reg_fsm/rst_n
add wave -noupdate /dig_core_tb/dut/i_reg_fsm/rx_done_i
add wave -noupdate /dig_core_tb/dut/i_reg_fsm/tx_done_i
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/data_i
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/reg_addr_o
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/reg_data_o
add wave -noupdate /dig_core_tb/dut/i_reg_fsm/rd_en_o
add wave -noupdate /dig_core_tb/dut/i_reg_fsm/wr_en_o
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/cmd_type_d
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/cmd_type_q
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/addr_d
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/addr_q
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/data_d
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_fsm/data_q
add wave -noupdate /dig_core_tb/dut/i_reg_fsm/state
add wave -noupdate /dig_core_tb/dut/i_reg_fsm/next_state
add wave -noupdate -divider REG_FILE
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/MAX_ADDR
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/addr_i
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/data_i
add wave -noupdate /dig_core_tb/dut/i_reg_file/wr_en_i
add wave -noupdate /dig_core_tb/dut/i_reg_file/nco_run_start_o
add wave -noupdate /dig_core_tb/dut/i_reg_file/nco_run_stop_o
add wave -noupdate /dig_core_tb/dut/i_reg_file/nco_load_start_o
add wave -noupdate /dig_core_tb/dut/i_reg_file/nco_load_ready_o
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/nco_freq_step_o
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/debug_data_o
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/reg_array_d
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/reg_array_q
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/reg_addr_d
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_reg_file/reg_addr_q
add wave -noupdate -divider MAIN_FSM
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_run_start_i
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_run_stop_i
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_load_start_i
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_load_ready_i
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_main_fsm/nco_freq_step_i
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_we_o
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_en_o
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_we_d
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_we_q
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_en_d
add wave -noupdate /dig_core_tb/dut/i_main_fsm/nco_en_q
add wave -noupdate /dig_core_tb/dut/i_main_fsm/state
add wave -noupdate /dig_core_tb/dut/i_main_fsm/next_state
add wave -noupdate -divider NCO
add wave -noupdate /dig_core_tb/dut/i_nco/MAX_ADDR
add wave -noupdate /dig_core_tb/dut/i_nco/STROBE_MAX
add wave -noupdate /dig_core_tb/dut/i_nco/we_i
add wave -noupdate /dig_core_tb/dut/i_nco/sys_en
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/data_i
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/freq_step_i
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/data_o
add wave -noupdate /dig_core_tb/dut/i_nco/ce
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/str_cnt_d
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/str_cnt_q
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/addr_cnt_d
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/addr_cnt_q
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/addr
add wave -noupdate -radix hexadecimal /dig_core_tb/dut/i_nco/content
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3090725806 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 279
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {10500 us}
log * -r
run 10ms