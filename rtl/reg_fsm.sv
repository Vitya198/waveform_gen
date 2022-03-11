module reg_fsm(
input wire           clk,
input wire           rst_n,
input logic          rx_done_i,
input logic          tx_done_i,	
input logic [7:0]    data_i,

output logic [7:0]    data_o,


output logic         tx_wr_o,	
output logic 	     main_fsm_en_o
);

// Parameters defining the register sources
localparam logic [7:0]    P_CMD_NOP  = 8'h00;
localparam logic [7:0]    P_CMD_WR   = 8'h01;
localparam logic [7:0]    P_CMD_RD   = 8'h02;

/*Register array*/
logic [7:0] reg_array_d [1:0];
logic [7:0] reg_array_q [1:0];
logic [7:0] reg_addr_d, reg_addr_q;


logic [7:0] add_d,   add_q ;
logic [7:0] data_d,  data_q;
logic       wr_d,    wr_q  ;

//-------------------------------------------------------------------------------------------------

typedef enum logic [1:0] {S_TYPE, S_ADD, S_DATA} state_t;   
state_t state, next_state;
	
//-------------------------------------------------------------------------------------------------
	
always_ff @ ( posedge clk, posedge rst_n ) begin
	if(!rst_n) begin
		state  <= S_TYPE;
		add_q  <= 1'b0;
		data_q <= 1'b0;
		wr_q   <= 1'b0;
	end
	else begin
	    state  <= next_state;
		add_q  <= add_d;
		data_q <= data_d;
		wr_q   <= wr_d;
    end
end

//-------------------------------------------------------------------------------------------------
always_comb begin
    next_state   =  state;
    add_d        =  add_q;  
    data_d       =  data_q;
    wr_d         =  wr_q;
    case (state)
        S_TYPE: begin
			       if(rx_done_i) begin
					   wr_d = 1'b0;
					   next_state = S_ADD;
					   if(data_i == P_CMD_WR) begin
						   wr_d       = 1'b1;
					   end   
				   end
		        end

        S_ADD:  begin
        		    if ( rx_done_i ) begin
                        next_state = S_DATA;
                        add_d      = data_i; 
                    end
        		end

        S_DATA:	begin
        			if ( rx_done_i ) begin
                        next_state = S_TYPE;
						wr_d       = 1'b0;
						if(wr_q) begin
							data_d  = data_i; 
						end
                    end
        		end
    endcase
end
//-------------------------------------------------------------------------------------------------

always_comb begin
	reg_array_d  =  reg_array_q;
	reg_addr_d   =  reg_addr_q;
	reg_addr_d   =  add_q;
	if(wr_q  &&  !wr_d) begin
		reg_array_d [reg_addr_d] = data_q;
	end
end

always_ff @(posedge clk) begin 
       reg_array_q = reg_array_d;
       reg_addr_q  = reg_addr_d;
end
//-------------------------------------------------------------------------------------------------
assign main_fsm_en_o = reg_array_q[0];    
	
endmodule