`timescale 1ns/10ps
module dig_core_tb();

//Inputs
logic           clk_i;
logic           rst_n_i;
logic           tx_wr_i;
logic [7:0]     tx_data_i;
logic           rx;
                  
//Outputs
logic           tx_done_o;
logic           rx_done_o;
logic [7:0]     rx_data_o;
logic           tx;
logic [7:0]     debug_o;


uart_transceiver uart_model(
  .sys_clk (clk_i     ),
  .sys_rst (!rst_n_i  ),
  .divisor (16'd326   ),
  .uart_rx (tx        ),
  .uart_tx (rx        ),
  .tx_data (tx_data_i ),
  .rx_data (rx_data_o ),
  .tx_wr   (tx_wr_i   ),
  .tx_done (tx_done_o ),
  .rx_done (rx_done_o )
);

dig_core dut(
  .clk      (clk_i      ),
  .rst_raw_n(rst_n_i    ),
  .rx_i     (rx         ),
  .tx_o     (tx         ),
  .debug_o  (debug_o    )
);

task send_bytes(input logic [7:0] data [0:2], int num_of_data );

  for(int x = 0; x < num_of_data; x++)begin
    tx_data_i = data[x];
    //test data valid pulse 
    @(posedge clk_i);
    #1ns;	 //  Data clock to Q
    tx_wr_i =   1; 
    @(posedge clk_i);
    #1ns;	 //  Data clock to Q
    tx_wr_i =   0;  
    @(posedge tx_done_o);
    #1ns;
  end
  
endtask;

task receive();
  @(posedge rx_done_o);
  #1ns;       //  Data clock to Q
  $display("%d",debug_o);
endtask

initial begin
clk_i       =   0;
rst_n_i     =   0;
tx_data_i   =   0;
tx_wr_i     =   0;

#1us;
rst_n_i     =   1;


//  test comes here

  #1ns;  
  send_bytes({ 8'h01, 8'h00, 8'ha1}, 3);
  #1ns; 
  send_bytes({8'h02, 8'h00, 8'h00}, 3);
  #1ns;
  receive();

// end of test

#1ms;

end 

always   begin 
  
 clk_i = 0;
 #10ns;
 clk_i= 1;
 #10ns;

end 

endmodule