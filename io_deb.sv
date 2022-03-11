`default_nettype none
//HP-féle debouncer ip core
module io_debouncer (
	input logic clk,
	input logic as_reset_n,
	input logic input_signal,
	output logic debounced_output
);

//-------------------------------------------------------------------------------------------------

	reg input_signal_ff_0;
	reg input_signal_ff_1;
	reg input_signal_ff_2;
	wire input_edge;
	
//-------------------------------------------------------------------------------------------------
	
	parameter counter_max = 1000000;
	reg [19:0] counter;

//-------------------------------------------------------------------------------------------------

	always_ff @ (posedge clk, negedge as_reset_n)
	begin
		if ( !as_reset_n ) begin
			input_signal_ff_0 <= 0;
			input_signal_ff_1 <= 0;
			input_signal_ff_2 <= 0;
		end
		else begin
			input_signal_ff_0 <= input_signal;
			input_signal_ff_1 <= input_signal_ff_0;
			input_signal_ff_2 <= input_signal_ff_1;
		end
	end
	assign input_edge = input_signal_ff_1 ^ input_signal_ff_2;
	
	always_ff @ (posedge clk, negedge as_reset_n)
	begin
		if ( !as_reset_n ) begin
			counter <= 0;
		end
		else begin
		
			if ( input_edge ) counter <= 0;
			else if ( counter < counter_max ) counter <= counter + 1;
		
		end
	end
	
	always_ff @ (posedge clk, negedge as_reset_n)
	begin
		if ( !as_reset_n ) begin
			debounced_output <= 0;
		end
		else begin
		
			if ( counter == counter_max ) debounced_output <= input_signal_ff_2;
		
		end
	end
	
endmodule
`default_nettype wire