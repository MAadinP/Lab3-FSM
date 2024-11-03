module lfsr_7 #(
    parameter D_WIDTH = 7
)(
    input   logic       clk,
    input   logic       rst,
    input   logic       en,
    output  logic [D_WIDTH-1:0] data_out
);

always_ff @(posedge clk) begin
    if (rst)
        data_out <= {{D_WIDTH-1{1'b0}}, 1'b1};
    else if (en)
        data_out <= {data_out[D_WIDTH-2:0], data_out[6] ^ data_out[2]};
end

endmodule
