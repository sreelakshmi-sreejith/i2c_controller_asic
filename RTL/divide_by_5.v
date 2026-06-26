module divide_by_5(
    input [15:0] x,
    output reg [7:0] y
);

always @(*)
    y = x / 5;

endmodule
