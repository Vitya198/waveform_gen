`default_nettype none
module nco (
    input  logic clk,
    input  logic rst_n,
    input  logic we_i,
    input  logic [7:0] data_i,
    input  logic [7:0] freq_step_i,
    output logic [7:0] data_o 
);

/*strobe_generator*/
logic ce;
logic [25:0]    str_cnt_d, str_cnt_q;

always_comb begin
    str_cnt_d   =   str_cnt_q;
    cy      =   (str_cnt_q  ==  520);

    if(cy) begin
        str_cnt_d   =   0;
    end

    else begin
        str_cnt_d   =   str_cnt_q   +   1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin 
    if(!rst_n) begin
        str_cnt_q   <=  'b0;
    end
    else begin
        str_cnt_q   <=  str_cnt_d;
    end
end
assign ce   =   str_cnt_q;
/*--------------------------------------------------------*/

/*address_counter*/
logic [12:0] addr_cnt_d, addr_cnt_q;
logic [12:0] addr;

always_comb begin 
    addr_cnt_d   =   addr_cnt_q;

    if(addr_cnt_q    ==  6000) begin
        addr_cnt_d   =   0;
    end else begin
        if(ce) begin
            if(we_i) begin
                addr_cnt_d   =   addr_cnt_q   +   1;
            end else begin
                addr_cnt_d   =   addr_cnt_q   +   freq_step_i;
            end
        end
    end
end

always_ff @(posedge clk or negedge rst_n ) begin 
    if(!rst_n) begin
        addr_cnt_q   <=  0;
    end
    else begin
        addr_cnt_q   <=   addr_cnt_d;
    end
end 

assign addr = addr_cnt_q;
/*--------------------------------------------------------*/

/*block_ram*/
reg [12:0] content [0:255];
always_ff @ (posedge clk )
	begin
		if ( we_i ) begin
			content[addr] <= data_i;
		end 
		data_o <= content[addr];
	end
/*--------------------------------------------------------*/

endmodule

`default_nettype wire
