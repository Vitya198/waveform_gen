`default_nettype none
module dig_core(
    input  wire clk,
    input  wire rst_raw_n,
    input  wire rx_i,

    output logic        tx_o,
    output logic [7:0]  debug_o  //led
);

//-------------------------------------------------------------------------------------------------

//set baudrate
parameter                 fclk      =   50000000;
parameter                 baudrate  =   9600;
localparam logic [15:0]   divisor   =   fclk/baudrate/16;

//-------------------------------------------------------------------------------------------------

logic rx_done, tx_done;
logic wr_en  , rd_en;

logic [7:0]  rx_data;
logic [7:0]  data_o;
logic [7:0]  reg_addr_o;
logic [7:0]  reg_data_o; 
   
//-------------------------------------------------------------------------------------------------

uart_transceiver i_uart_transcevier(
  .sys_clk    (clk          ),
  .sys_rst    (!rst_raw_n   ),
  .divisor    (divisor      ),
  .uart_rx    (rx_i         ),
  .uart_tx    (tx_o         ),
  .rx_done    (rx_done      ),
  .tx_done    (tx_done      ),
  .tx_data    (reg_data_o   ),
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
  .reg_data_o  (reg_data_o  ),
  .reg_addr_o  (reg_addr_o  ), 
  .rd_en_o     (rd_en       ),
  .wr_en_o     (wr_en       )
);

//-------------------------------------------------------------------------------------------------

reg_file i_reg_file(
  .clk        (clk        ),
  .rst_n      (rst_raw_n  ),
  .addr_i     (reg_addr_o ),
  .data_i     (reg_data_o ),
  .wr_en_i    (wr_en      ),
  .data_o     (data_o     )  
);

//-------------------------------------------------------------------------------------------------

assign debug_o = data_o; 

endmodule
`default_nettype wire