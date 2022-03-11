module fsm(
    input wire clk,
    input wire as_reset_n,

    input logic [7:0] fsm_ctrl;
);

assign logic en = fsm_ctrl[0];


endmodule
