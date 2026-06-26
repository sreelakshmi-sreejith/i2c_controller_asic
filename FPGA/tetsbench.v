`timescale 1ns / 1ps

module tb;

    // Testbench Signals
    reg clk_100mhz;
    wire tmp_sda;
    wire tmp_scl;
    wire [6:0] seg;
    wire [7:0] an;
    wire [15:0] led;

    // ---------------------------------------------------------
    // ADD THESE TWO LINES RIGHT HERE
    // ---------------------------------------------------------
    pullup(tmp_sda);
    pullup(tmp_scl);

    // Instantiate Top Module
    top sut (
        .CLK100MHZ(clk_100mhz),
        .TMP_SDA(tmp_sda),
        .TMP_SCL(tmp_scl),
        .SEG(seg),
        .AN(an),
        .LED(led)
    );
    // ---------------------------------------------------------
    // BI-DIRECTIONAL I2C SDA HANDLING FOR CADENCE
    // ---------------------------------------------------------
    reg sda_driver = 1'b1;
    reg mock_sensor_active = 1'b0;

    // Clean tri-state logic to prevent "X" (unknown) conflicts
    assign tmp_sda = (mock_sensor_active) ? sda_driver : 1'bz;

    // ---------------------------------------------------------
    // MOCK I2C SENSOR (ADT7420)
    // Target Temp: 25C (Hex: 0x19) -> 77F (Hex: 0x4D)
    // ---------------------------------------------------------
    reg [7:0] mock_celsius_data = 8'h19; 
    integer i;

    initial begin
        forever begin
            // Wait for START condition (SDA drops while SCL is High)
            @(negedge tmp_sda);
            if (tmp_scl === 1'b1) begin
                
                // Wait out the 8 bits of Address + R/W
                for (i = 0; i < 8; i = i + 1) begin
                    @(posedge tmp_scl);
                end
                
                // Sensor drives ACK
                @(negedge tmp_scl);
                mock_sensor_active = 1'b1;
                sda_driver = 1'b0; 
                
                // Release ACK
                @(negedge tmp_scl);
                mock_sensor_active = 1'b0; 
                
                // Send MSB Byte (Temperature Data)
                for (i = 7; i >= 0; i = i - 1) begin
                    @(negedge tmp_scl);
                    mock_sensor_active = 1'b1;
                    sda_driver = mock_celsius_data[i];
                end
                
                // Release for Master's ACK
                @(negedge tmp_scl);
                mock_sensor_active = 1'b0;
                
                // Send LSB Byte (Dummy 0s, your master drops these anyway)
                for (i = 7; i >= 0; i = i - 1) begin
                    @(negedge tmp_scl);
                    mock_sensor_active = 1'b1;
                    sda_driver = 1'b0; 
                end
                
                // Release line for final Master NACK
                @(negedge tmp_scl);
                mock_sensor_active = 1'b0;
            end
        end
    end

    // ---------------------------------------------------------
    // CLOCK AND RUNTIME EXECUTION
    // ---------------------------------------------------------
    
    // Generate 100MHz Clock (10ns period)
    always begin
        #5 clk_100mhz = ~clk_100mhz;
    end

    initial begin
        clk_100mhz = 0;

        $display("========================================");
        $display("Starting Simulation...");
        $display("Waiting ~10ms for I2C Master POWER_UP state to finish...");
        
        // Wait 15,000,000 ns (15ms) to guarantee completion of the bus transaction
        #15000000;

        $display("========================================");
        $display("--- FINAL RESULTS ---");
        $display("Raw LED Output : %b", led);
        $display("Celsius (Hex)  : 0x%h (Dec: %d C)", led[7:0], led[7:0]);
        $display("Fahrenheit(Hex): 0x%h (Dec: %d F)", led[15:8], led[15:8]);
        
        if (led[7:0] == 8'h19 && led[15:8] == 8'h4D) begin
            $display(">> STATUS: PASS! Values converted correctly.");
        end else begin
            $display(">> STATUS: FAIL. Check waveforms.");
        end
        $display("========================================");
        
        $finish;
    end

endmodule
