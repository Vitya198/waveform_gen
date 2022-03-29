`default_nettype none
module main_fsm(
input wire           clk,
input wire           rst_n,

//nco control fsm input
input wire          nco_run_start_i,
input wire          nco_run_stop_i,
input wire          nco_load_start_i,
input wire          nco_load_ready_i,

input wire [13:0]   nco_freq_step_i,

//control_2_nco
output logic        nco_we_o,
output logic        nco_en_o
);

//-------------------------------------------------------------------------------------------------
logic nco_we_d,     nco_we_q;
logic nco_en_d,     nco_en_q;
//-------------------------------------------------------------------------------------------------

typedef enum logic [2:0] {S_IDLE, S_RUN, S_WAIT, S_LOAD } state_t;
state_t state, next_state;

//-------------------------------------------------------------------------------------------------

always_ff @( posedge clk, negedge rst_n ) begin
  if(!rst_n) begin
    state     <=  S_IDLE;
    nco_we_q  <=  'd0;
  end
  else begin
    state <= next_state;
    nco_we_q  <= nco_we_d ;
  end
end

//-------------------------------------------------------------------------------------------------

always_comb begin
  next_state  =  state;
  nco_we_d    =  nco_we_q ;

  case(state)
    S_IDLE: begin
      if(nco_run_start_i) begin
        next_state = S_RUN;
      end
      if(nco_load_start_i) begin
        next_state = S_LOAD;
      end
    end

    S_LOAD: begin
        //betöltünk a memóriába, nco_we-t állítjuk
      if(nco_load_ready_i) begin
        nco_we_d = 0;
        next_state = S_IDLE;
      end  
      else begin
        nco_we_d = 1;
      end 
    end

    S_RUN: begin
      if(nco_run_stop_i) begin
        nco_en_d   =  0;
        next_state =  S_IDLE;
      end
      else begin
        if(nco_freq_step_i) begin
          nco_en_d  =  1; 
        end
        else begin
          nco_en_d   = 0;
          next_state = S_WAIT;
        end
      end
    end

    S_WAIT: begin
      if(nco_freq_step_i) begin
        next_state = S_RUN;
      end
    end

  endcase
end

//-------------------------------------------------------------------------------------------------

assign nco_we_o  =  nco_we_q;
assign nco_en_o  =  nco_en_q;

endmodule
`default_nettype wire 