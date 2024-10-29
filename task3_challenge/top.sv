module top #(
    parameter   N_WIDTH = 16,
                LIGHT_WIDTH = 8
) (
    input logic                 en,
    input logic                 rst,
    input logic                 clk,
    input logic [N_WIDTH-1:0]     Number,
    output logic [LIGHT_WIDTH-1:0] dout
);

logic tickout;

clktick ticker (
    .clk (clk),
    .N (Number),
    .en (en),
    .rst (rst),
    .tick (tickout)
);

f1_fsm lights (
    .clk (clk),
    .en (tickout),
    .rst (rst),
    .data_out (dout)
);
    
endmodule
