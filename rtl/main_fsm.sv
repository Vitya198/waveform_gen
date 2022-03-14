`default_nettype none
module main_fsm(

    input wire           clk,
    input wire           reset_n,
    input logic          en_i,
    input logic          mfsm_reg1_i,
    input logic          mfsm_reg2_i,
    input logic          mfsm_reg3_i,

    //nco control fsm input
    input logic          nco_en_i,
    input logic [13:0]   nco_freq_step_i,

    /*dac control fsm input
    input logic          dac_en_i,
    input logic          dac_scale_i,
    */

    //nco control fsm output
    output logic       nco_we_o,
    output logic [7:0] nco_data_o,
    output logic [13:0] nco_freq_step_o

);

//-------------------------------------------------------------------------------------------------

typedef enum logic [2:0] {S_IDLE, S_RUN, S_LOAD, S_DUMP } state_t;
state_t state, next_state;

//-------------------------------------------------------------------------------------------------

always_ff @( posedge clk, negedge rst_n ) begin
    if(!rst_n) begin
        state <= S_IDLE;
        xx_q  <= 'd0;
        xx_q  <= 'b0;
    end
    else begin
        state <= next_state;
        xx_q  <= xx_d;
        xx_q  <= xx_d;
    end
end

//-------------------------------------------------------------------------------------------------

always_comb begin
    next_state = state;
    xx_d       = xx_q;
    xx_d       = xx_q;
    xx_d       = xx_q;

    case(state)
      S_IDLE: begin
          -------
      end

      S_RUN: begin
          -----
      end

      S_LOAD: begin
          -----
      end

      S_DUMP: begin
          -----
      end

    endcase
end

//-------------------------------------------------------------------------------------------------

assign nco_we_o;
assign nco_data_o;
assign nco_freq_step_o;
assign...

endmodule
`default_nettype wire 