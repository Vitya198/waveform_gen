`default_nettype none
module reg_file (
  
  input  wire          clk,
  input  wire          rst_n,

  input  wire  [7:0]   addr_i,
  input  wire  [7:0]   data_i,
  input  wire          wr_en_i,


  //nco_control
  output logic        nco_run_start_o,
  output logic        nco_run_stop_o,
  output logic        nco_load_start_o,
  output logic        nco_load_ready_o,

  output logic [13:0] nco_freq_step_o,

  output logic [7:0] debug_data_o

);

//-------------------------------------------------------------------------------------------------
parameter logic [7:0] MAX_ADDR       = 8'd8;
/*register array*/
logic [7:0] reg_array_d [MAX_ADDR-1:0];
logic [7:0] reg_array_q [MAX_ADDR-1:0];
logic [7:0] reg_addr_d, reg_addr_q;

//-------------------------------------------------------------------------------------------------

always_comb begin
  reg_array_d  =  reg_array_q;
  reg_addr_d   =  reg_addr_q;
  if(wr_en_i) begin
    reg_array_d [reg_addr_q] = data_i;
  end
end

//-------------------------------------------------------------------------------------------------

always_ff @(posedge clk, negedge rst_n) begin 
  if(!rst_n) begin
    reg_array_q[0] <= 8'd0;
    reg_array_q[1] <= 8'd0;
    reg_array_q[2] <= 8'd0;
    reg_array_q[3] <= 8'd0;
    reg_array_q[4] <= 8'd0;
    reg_array_q[5] <= 8'd0;
    reg_array_q[6] <= 8'd0;
    reg_array_q[7] <= 8'd0;
    reg_addr_q     <= 8'd0;
    end 
    else begin
      reg_array_q     <= reg_array_d;
      reg_addr_q      <= reg_addr_d;
    end
end

//-------------------------------------register disitribution-------------------------------------------------

//nco control registers
assign  nco_run_start_o         = reg_array_q[0][0];
assign  nco_run_stop_o          = reg_array_q[0][1];
assign  nco_load_start_o        = reg_array_q[0][2];
assign  nco_load_ready_o        = reg_array_q[0][3];

assign  nco_freq_step_o[7:0]    = reg_array_q[1][7:0];
assign  nco_freq_step_o[13:8]   = reg_array_q[2][5:0];

//read register file
assign debug_data_o  = reg_array_d [reg_addr_q];
    
endmodule
`default_nettype wire    