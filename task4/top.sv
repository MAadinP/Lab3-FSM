module top #(
    parameter   N_WIDTH = 5,
                K_WIDTH = 7,
                OUT_WIDTH = 8
)(
    input logic                     clk,
    input logic                     rst,
    input logic [N_WIDTH-1:0]       n,
    input logic                     trigger,
    input logic                     alwayslow,
    input logic                     alwayshigh,       
    output logic                    cmd_delay,
    output logic                    cmd_seq,
    output logic [OUT_WIDTH-1:0]    data_out
);

logic [K_WIDTH-1:0] connection;
logic A;
logic B;
logic muxout;

assign muxout = cmd_seq ? A : B;

clktick ticker (
    .tick (A),
    .clk (clk),
    .en (cmd_seq),
    .rst (rst),
    .N (n)
);

lfsr_7 numgen (
    .clk (clk),
    .en (alwayshigh),
    .rst (alwayslow),
    .data_out (connection)
);

delay delay (
    .time_out (B),
    .clk (clk),
    .trigger (cmd_delay),
    .rst (rst),
    .n (connection)
);

f1_fsm statemachine (
    .rst (rst),
    .en (muxout),
    .trigger (trigger),
    .clk (clk),
    .cmd_delay (cmd_delay),
    .cmd_seq (cmd_seq),
    .data_out (data_out)
);

endmodule
