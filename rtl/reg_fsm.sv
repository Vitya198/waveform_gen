module reg_fsm(
   input wire  		 clk,
   input wire  		 rst_n,
   input wire		 rx_done,
   input logic       tx_done,	
   input logic [7:0] data_i,

   output logic 	tx_wr,	
   output logic 	mfsm
);

/*Commands*/
parameter cmd	=		8'd1;

/*Register array*/
logic [7:0] reg_array [1:0];
logic [7:0] reg_addr;

//------------------ -------------------------------------------------------------------------------

	typedef enum logic [1:0] { T, address, data } state_t;
	state_t state, next_state;
	
//-------------------------------------------------------------------------------------------------
	
	always_ff @ ( posedge clk, posedge rst_n )
	begin
		if ( !rst_n ) state <= T;
		else state <= next_state;

	end
	
//-------------------------------------------------------------------------------------------------
logic wr_en;
    always_comb
	begin
		//default to prevent latch synthesis 
		next_state	<=	state;
		reg_array[0]	<= 0;
		case (state)
			T:		begin
						if ( rx_done) begin
							if(data_i == cmd) begin
								wr_en	<=1;
								next_state	<=	address;
							end
							else begin
								wr_en<=0;
								$display("fsm_error");
							end
						end
						else begin
							next_state	<=	T;
						end
					end
					
			address:begin
						if ( rx_done ) begin
                            next_state <= data ;
                            reg_addr   <= data_i; 
                        end
						else begin 
							next_state <= address;
						end
					end

            data:	begin
						if ( rx_done ) begin
                            next_state <= T;
							if(wr_en) begin
								reg_array[reg_addr] <= data_i;
							end
                        end
						else begin 
							next_state <= data;
						end
					end
		endcase
	end

assign mfsm = reg_array[0];    
	
endmodule