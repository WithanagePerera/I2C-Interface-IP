// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Basic tb for the counter entity.

// Time unit is 1ns, and precision is 1 ps
`timescale 1ns/1ps

module counter_tb;

    localparam int COUNTER_WIDTH = 8;

    logic clk, enable, rst;
    logic count [COUNTER_WIDTH-1:0];

    // Entity instantiation
    counter #(.WIDTH(COUNTER_WIDTH)) DUT (
        .FPGA_clk(clk),
        .enable(enable),
        .rst(rst),

        .count(count)
    );

    // Defaulting my values
    initial begin
        clk = 1'b0;
        enable = 1'b0;
        rst = 1'b1;
    end

    // Initializing the clk
    always #5 clk = ~clk;

    // Start of testbench
    initial begin
        $display("Starting Testbench!");


        // #20 rst <= 0;
        // Instead of hard-coding the delay for rst, let's base it off of clock cycles
        repeat (2) @(posedge clk);
        rst = 1'b0;
        
        for (int i = 0; i < 20; i++) begin
            // Waiting for positive edges
            @(posedge clk);
            
            // To get an alternating pattern to exercise the enables, I'll have it switch off
            // when we reach a multiple of 3
            if (i%3 == 0)
                enable <= 1'b0;
            else
                enable <= 1'b1;
        end
    end

endmodule