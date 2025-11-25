// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Basic testbench for the data in decoder.

`timescale 1ns/1ps

module data_in_tb;

    localparam int NUM_BYTES = 6;
    localparam int SCL_half_period = 10; // In nanoseconds, HAS to be even
    localparam int FPGA_clk_half_period = SCL_half_period/2;

    logic clk, SCL, SCL_prev, SDA, SDA_prev, enable, rst;
    logic done, SDA_down;
    logic [3:0] HEX_out [NUM_BYTES-1:0];

    // The data that I'm going to transmit
    logic [7:0] data_to_send [NUM_BYTES-1:0];

    // Now I want to initialize the unpacked matrix with some data
    initial begin
        for (int x = 0; x < NUM_BYTES; x++) begin
            for (int y = 0; y < 8; y++) begin
                if (x%2 == 0) begin
                    if ((x+y)%3 == 0)
                        data_to_send[x][y] = 1'b1;
                    else
                        data_to_send[x][y] = 1'b0;
                end else begin
                    if ((x+y)%2 == 0)
                        data_to_send[x][y] = 1'b1;
                    else
                        data_to_send[x][y] = 1'b0;
                end
            end
        end
    end

    // Set some initial values
    initial begin
        clk = 1'b0;
        SCL = 1'b0;
        enable = 1'b1;
        rst = 1'b1;
    end

    data_in_top_level #(.NUM_BYTES(NUM_BYTES)) UUT (
        .FPGA_clk(clk),
        .SCL(SCL),
        .SCL_prev(SCL_prev),
        .SDA(SDA),
        .SDA_prev(SDA_prev),
        .enable(enable),
        .rst(rst),

        .done(done),
        .SDA_down(SDA_down),
        .HEX_out(HEX_out)
    );

    // Keeps track of the previous values of SCL and SDA (to help with detecting rising/falling edges)
    always_ff @(posedge clk) begin
        SCL_prev <= SCL;
        SDA_prev <= SDA;
    end

    // Initialize the clocks
    always #FPGA_clk_half_period clk = ~clk;
    always #SCL_half_period SCL = ~SCL;

    // Start of actual testbench
    initial begin

        $display("Starting Testbench!");

        // Holding reset true for a single clock
        @(posedge clk);
        rst = 1'b0;

        // Outer loop over the bytes
        for (int x = 0; x < NUM_BYTES; x++) begin
            
            // Inner loop over the bits
            for (int y = 7; y >= 0; y--) begin

                // I'll update SDA when SCL is low
                @(negedge SCL);
                #FPGA_clk_half_period;

                SDA = data_to_send[x][y];
            end

            // Setting the acknowledge bit
            // @(negedge SCL);
            // SDA_down = 1'b1;

            // Setting stop condition
            @(negedge SCL);
            @(posedge SCL);
            #FPGA_clk_half_period;
            SDA = 1'b1;

            // #FPGA_clk_half_period;

            // After each byte, let's check that the data decoder processed it correctly by looking at the HEX outputs
            if (HEX_out[x] != data_to_send[x][3:0])
                $display("[%0t] ERROR: Nibble does not match for Byte=%0d, Sent=%b but Received=%b", $time, x, data_to_send[x][3:0], HEX_out[x]);
        end

        $display("Testbench completed!");
        $finish;

    end

endmodule
