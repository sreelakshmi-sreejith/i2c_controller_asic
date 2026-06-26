module i2c_master(
    input        clk_200kHz,
    inout        SDA,
    output       SCL,
    output [7:0] temp_data
);

// Generate 10 kHz SCL from 200 kHz clock
reg [3:0] counter;
reg scl_reg;
assign SCL = scl_reg;

// I²C Master FSM
localparam POWER_UP  = 0,
           START     = 1,
           SEND_ADDR = 2,
           REC_ACK   = 3,
           REC_MSB   = 4,
           SEND_ACK  = 5,
           REC_LSB   = 6,
           NACK      = 7;

reg [2:0] state;

// Temperature registers
reg [7:0] tMSB, tLSB;
reg [7:0] temp_reg;

// SDA Tri-state Control
assign SDA = (drive_enable) ? sda_out : 1'bz;
wire sda_in = SDA;

// FSM (simplified)
always @(posedge clk_200kHz) begin
    case(state)
        POWER_UP : /* Wait for sensor startup */;
        START    : /* Generate START condition */;
        SEND_ADDR: /* Send 7-bit address + Read bit */;
        REC_ACK  : /* Receive slave ACK */;
        REC_MSB  : /* Read temperature MSB */;
        SEND_ACK : /* Master ACK */;
        REC_LSB  : /* Read temperature LSB */;
        NACK     : begin
            temp_reg <= {tMSB[6:0], tLSB[7]};
            state <= START;
        end
    endcase
end

assign temp_data = temp_reg;

endmodule
