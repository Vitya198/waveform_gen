module reg_fsm(
input wire           clk,
input wire           rst_n,
input logic          rx_done_i,
input logic          tx_done_i,	
input logic [7:0]    data_i,

output logic [7:0]   data_o,
output logic         tx_wr_o,	
output logic [7:0]   debug_o,
output logic [7:0]   reg_data_o,
output logic         reg_data_valid_o
);


//-------------------------------------------------------------------------------------------------
typedef enum  logic [1:0] {CMD_NOP, CMD_WR, CMD_RD  } cmd_type;
cmd_type cmd_type_d, cmd_type_q;
//-------------------------------------------------------------------------------------------------

/*Register array*/
logic [7:0] reg_array_d [1:0];
logic [7:0] reg_array_q [1:0];
logic [7:0] reg_addr_d, reg_addr_q;


logic [7:0] addr_d,   addr_q ;
logic [7:0] data_d,   data_q;
logic       wr_en,    rd_en ;

//-------------------------------------------------------------------------------------------------

typedef enum logic [1:0] {S_TYPE, S_ADD, S_DATA} state_t;   
state_t state, next_state;
	
//-------------------------------------------------------------------------------------------------
	
always_ff @ ( posedge clk, posedge rst_n ) begin
	if(!rst_n) begin
		state      <= S_TYPE;
		cmd_type_q <= CMD_NOP;
		addr_q     <= 1'b0;
		data_q     <= 1'b0;
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

        S_ADD:  begin
        		    if ( rx_done_i ) begin
                        next_state = S_DATA;
                        addr_d     = data_i; 
                    end
        		end

        S_DATA:	begin
        			if ( rx_done_i ) begin
                        next_state = S_TYPE;
						cmd_type_d  = P_CMD_NOP;
                    end
        		end
    endcase
end

//-------------------------------------------------------------------------------------------------

assign wr_en = (cmd_type_q == CMP_WR) &&  (state == S_DATA) && rx_done_i;
assign rd_en = (cmd_type_q == CMP_RD) &&  (state == S_DATA) && rx_done_i;

assign reg_data_o        = reg_array_d [reg_addr_q];
assign reg_data_valid_o  = rd_en ;

endmodule