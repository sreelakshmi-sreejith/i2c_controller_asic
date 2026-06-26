module top(
    input clk_100MHz,
    input SW,
    inout TMP_SDA,
    output TMP_SCL,
    output [0:6] SEG,
    output [3:0] AN,
    output [7:0] LED
);

wire w_200kHz;
wire [7:0] c_data;
wire [7:0] f_data;

i2c_master master(...);

clkgen_200kHz cgen(...);

seg7 seg(...);

temp_converter tc(...);

assign LED = SW ? f_data : c_data;

endmodule
