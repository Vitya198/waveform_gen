module reg_file #(
    parameter logic [7:0] MAX_ADDR   = 8'd8;
) (
    input wire           clk,
    input wire           rst_n,

    input  wire  [7:0]   addr_i,
    input  wire  [7:0]   data_i,
    input  wire  [7:0]   wr_en_i,

    //mfsm control register 1 byte
    output logic mfsm_en_o,
    output logic mfsm_reg1_o,
    output logic mfsm_reg2_o,

    //nco_control
    output logic nco_en_o,
    output logic [13:0] nco_freq_set_o

);

//segédváltozók
logic [7:0] reg_array_d [MAX_ADDR-1:0];
logic [7:0] reg_array_q [MAX_ADDR-1:0];

always_comb begin
	reg_array_d  =  reg_array_q;
	reg_addr_d   =  reg_addr_q;
	reg_addr_d   =  addr_q;
	if(wr_en_i) begin
		reg_array_d [reg_addr_q] = data_i;
	end
end

always_ff @(posedge clk) begin 
	if(!rst_n) begin
		reg_array_q[0] <= 8'b0;
        reg_array_q[1] <= 8'b0;
        reg_array_q[2] <= 8'b0;
        reg_array_q[3] <= 8'b0;
        reg_array_q[4] <= 8'b0;
        reg_array_q[5] <= 8'b0;
        reg_array_q[6] <= 8'b0;
        reg_array_q[7] <= 8'b0;
        reg_addr_q     <= 8'b0;
	end
       reg_array_q     <= reg_array_d;
       reg_addr_q      <= reg_addr_d;
end
    

//-----------register dsitribution-------------------------------------------------

/*main fsm control*/
assign  mfsm_en_o     = reg_array_q[0][0];
assign  mfsm_xx_o     = reg_array_q[0][1];
assign  mfsm_xx_o     = reg_array_q[0][2];
assign  mfsm_xx_o     = reg_array_q[0][3];
assign  mfsm_xx_o     = reg_array_q[0][4];
assign  mfsm_xx_o     = reg_array_q[0][5];
assign  mfsm_xx_o     = reg_array_q[0][6];
assign  mfsm_xx_o     = reg_array_q[0][7];

/*nco control registers*/
assign  nco_xx        = reg_array_q[1][0];
assign  nco_xx        = reg_array_q[1][1];
assign  nco_xx        = reg_array_q[1][2];

assign  nco_xx        = reg_array_q[1][3];
assign  nco_xx        = reg_array_q[1][4];
assign  nco_xx        = reg_array_q[1][5];
assign  nco_xx        = reg_array_q[1][6];
assign  nco_xx        = reg_array_q[1][7];
assign  nco_xx        = reg_array_q[2][0];
assign  nco_xx        = reg_array_q[2][1];
assign  nco_xx        = reg_array_q[2][2];
assign  nco_xx        = reg_array_q[2][3];
assign  nco_xx        = reg_array_q[2][4];
assign  nco_xx        = reg_array_q[2][5];
assign  nco_xx        = reg_array_q[2][6];
assign  nco_xx        = reg_array_q[2][7];


assign  mfsm_reg1_o   = reg_array_q[3][0];
assign  mfsm_reg1_o   = reg_array_q[3][1];
assign  mfsm_reg1_o   = reg_array_q[3][2];
assign  mfsm_reg1_o   = reg_array_q[3][3];
assign  mfsm_reg1_o   = reg_array_q[3][4];
assign  mfsm_reg1_o   = reg_array_q[3][5];
assign  mfsm_reg1_o   = reg_array_q[3][6];
assign  mfsm_reg1_o   = reg_array_q[3][7];
    
endmodule