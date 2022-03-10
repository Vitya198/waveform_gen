`default_nettype none
module dig_core(
    input wire clk,
    input wire rst_raw_n,
    input wire rx_i,

    output logic tx_o,
    //output logic [7:0]  dac_o,
    output logic [7:0]  debug_o  //led
);

//set baudrate
parameter           fclk      =   50000000;
parameter           baudrate  =   9600;
localparam [15:0]   divisor   =   fclk/baudrate/16;

logic rx_done, tx_done;
logic [7:0] reg_rx_data, reg_tx_data;

logic send_q , send_d;

uart_transceiver i_uart_transcevier(
  .sys_clk    (clk          ),
  .sys_rst    (!rst_raw_n   ),
  .uart_rx    (rx_i         ),
  .divisor    (divisor      ),
  .tx_data    (reg_tx_data  ),
  .tx_wr      (send_q       ),
  .uart_tx    (tx_o         ),
  .rx_data    (reg_rx_data  ),
  .rx_done    (rx_done      ),
  .tx_done    (tx_done      )
);

reg_fsm i_reg_fsm(
  .clk        (clk          ),
  .rst_n      (rst_raw_n    ),
  .rx_done    (rx_done      ),
  .tx_done    (tx_done      ),
  .data_i     (reg_rx_data  ),
  .tx_wr      (send_q       ),
  .mfsm       (debug_o      )
);

/*Invert and sends back the incoming data*/
 /* always_comb begin
    inv_data_d =  inv_data_q;
	  send_d     = 1'b0;
    if ( rx_done ) begin
      inv_data_d = ~reg_rx_data;
	  send_d     = 1'b1;
    end
  end 

  always_ff @ (posedge clk or negedge rst_raw_n) begin
    if (!rst_raw_n) begin
	    inv_data_q =    'b0;
	    send_q     =    'b0;
    end
    else begin
	    inv_data_q =    inv_data_d;
	    send_q     = 	send_d;
    end
  end
 */
endmodule
`default_nettype wire