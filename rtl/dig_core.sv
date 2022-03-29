`default_nettype none
module dig_core(
input  wire         clk,
input  wire         rst_raw_n,
input  wire         rx_i,
  
output logic        tx_o,    
output logic [7:0]  dig_out, //nco kiemenete
output logic [7:0]  debug_o  //led
);
//-------------------------------------------------------------------------------------------------
//set baudrate 
parameter                fclk      =  50000000; //50MHz
parameter                baudrate  =  9600;    
localparam logic [15:0]  divisor   =  fclk/baudrate/16;
//-------------------------------------------------------------------------------------------------
/*UART resources*/
logic rx_done, tx_done;  
logic rd_en,   wr_en;    //olvasás/írás a regiszter fájlból/fájlba 

/*register fsm resources*/
logic [7:0]  rx_data;
logic [7:0]  reg_addr;
logic [7:0]  reg_data; 
   
/*reg file and main fsm resoruces*/
logic run_start;
logic run_stop;
logic load_start;
logic load_ready;
logic [7:0]  debug_data;

/*nco resources*/
logic        nco_we;
logic        nco_en;
logic [7:0]  nco_out; 
logic [13:0] freq_step;     
//-------------------------------------------------------------------------------------------------
uart_transceiver i_uart_transcevier(
  .sys_clk    (clk          ),
  .sys_rst    (!rst_raw_n   ),
  .divisor    (divisor      ),
  .uart_rx    (rx_i         ),
  .uart_tx    (tx_o         ),
  .rx_done    (rx_done      ),
  .tx_done    (tx_done      ),
  .tx_data    (reg_data     ), 
  .rx_data    (rx_data      ),
  .tx_wr      (rd_en        )
);
//-------------------------------------------------------------------------------------------------
reg_fsm i_reg_fsm(    
  .clk         (clk         ),
  .rst_n       (rst_raw_n   ),
  .rx_done_i   (rx_done     ),
  .tx_done_i   (tx_done     ),
  .data_i      (rx_data     ),
  .reg_data_o  (reg_data    ),
  .reg_addr_o  (reg_addr    ), 
  .rd_en_o     (rd_en       ),
  .wr_en_o     (wr_en       )
);
//-------------------------------------------------------------------------------------------------
reg_file i_reg_file(
  .clk              (clk        ),
  .rst_n            (rst_raw_n  ),

  .addr_i           (reg_addr   ),
  .data_i           (rx_data    ),
  .wr_en_i          (wr_en      ),
  .debug_data_o     (debug_data ),

  .nco_run_start_o  (run_start  ),
  .nco_run_stop_o   (run_stop   ),
  .nco_load_start_o (load_start ),
  .nco_load_ready_o (load_ready ),

  .nco_freq_step_o  (freq_step  )
);
//-------------------------------------------------------------------------------------------------
main_fsm i_main_fsm(
  .clk              (clk        ),
  .rst_n            (rst_raw_n  ),

  .nco_run_start_i  (run_start  ),
  .nco_run_stop_i   (run_stop   ),
  .nco_load_start_i (load_start ),
  .nco_load_ready_i (load_ready ),

  .nco_freq_step_i  (freq_step  ),

  .nco_we_o         (nco_we     ),
  .nco_en_o         (nco_en     )
);
//-------------------------------------------------------------------------------------------------
nco i_nco(
  .clk         (clk       ),
  .rst_n       (rst_raw_n ),
  .we_i        (nco_we    ),
  .sys_en      (nco_en    ),
  .freq_step_i (freq_step ),
  .data_i      (rx_data   ),  //betölteni kívánt adatok??shifteljem be egy regiszteren keresztül?
  .data_o      (nco_out   )
);
//-------------------------------------------------------------------------------------------------
assign debug_o = debug_data; 
assign dig_out = nco_out;

endmodule
`default_nettype wire