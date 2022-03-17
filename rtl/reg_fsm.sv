`default_nettype none
module reg_fsm(
input  wire         clk,
input  wire         rst_n,
input  wire         rx_done_i,
input  wire         tx_done_i,	
input  wire  [7:0]  data_i,
 
output logic [7:0]  reg_addr_o,
output logic [7:0]  reg_data_o,
output logic        rd_en_o,
output logic        wr_en_o
);

//-------------------------------------------------------------------------------------------------

localparam logic [7:0] CMD_NOP = 8'h00;
localparam logic [7:0] CMD_WR  = 8'h01;
localparam logic [7:0] CMD_RD  = 8'h02; 
logic [7:0] cmd_type_d, cmd_type_q;

//-------------------------------------------------------------------------------------------------

logic [7:0] addr_d,   addr_q ;
logic [7:0] data_d,   data_q;

//-------------------------------------------------------------------------------------------------

typedef enum logic [1:0] {S_TYPE, S_ADD, S_DATA} state_t;   
state_t state, next_state;

//-------------------------------------------------------------------------------------------------

always_ff @ ( posedge clk, posedge rst_n ) begin
  if(!rst_n) begin
    state      <= S_TYPE;
    cmd_type_q <= CMD_NOP;
    addr_q     <= 'd0;
    data_q     <= 'd0;
  end
  else begin
    state      <= next_state;
    cmd_type_q <= cmd_type_d;
    addr_q     <= addr_d;
    data_q     <= data_d;
  end
end

//-------------------------------------------------------------------------------------------------

always_comb begin
  next_state   =  state;
	cmd_type_d   =  cmd_type_q;
  addr_d       =  addr_q;  
  data_d       =  data_q;

  case (state)
    S_TYPE: begin
	    if(rx_done_i) begin
	      next_state = S_ADD;
	      cmd_type_d = data_i;  
	    end
	  end  

    S_ADD: begin
    	if ( rx_done_i ) begin
        next_state = S_DATA;
        addr_d     = data_i; 
      end
    end

    S_DATA:	begin
    	if ( rx_done_i ) begin
        next_state  = S_TYPE;
	  	  cmd_type_d  = CMD_NOP;
	  	  data_d  = data_i;
      end
    end
  endcase
end

//-------------------------------------------------------------------------------------------------

assign wr_en_o    = ((cmd_type_q == CMD_WR) &&  (state == S_DATA) && rx_done_i);
assign rd_en_o    = ((cmd_type_q == CMD_RD) &&  (state == S_DATA) && rx_done_i);
assign reg_data_o = data_q;
assign reg_addr_o = addr_q;

endmodule
`default_nettype wire   