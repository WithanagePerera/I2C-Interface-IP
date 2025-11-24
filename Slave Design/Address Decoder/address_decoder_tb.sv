// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Basic testbench for the address decoder unit. I'll test using an invalid address, then a matching address.

`timescale 1ns/1ps;

module address_decoder_tb;

    logic clk, SCL, SCL_prev, SDA, enable, rst;
    logic done, selected;

    logic [6:0] correct_I2C_addr = 7'b0001000;
    logic [6:0] incorrect_I2C_addr = 7'b0010010; // I'll use this one during testing to validate if my design correctly distinguishes correct from incorrect addresses
    
    // Setting initial values
    initial begin
        clk = 1'b0;
        SCL = 1'b0;
        SCL_prev = 1'b0;
        SDA = 1'b1;
        enable = 1'b0;
        rst = 1'b1;
    end

    always_ff @(posedge SCL) begin
        SCL_prev <= SCL;
    end

    // Entity instantiation
    address_decoder_top UUT (
        .FPGA_clk(clk),
        .SCL(SCL),
        .SCL_prev(SCL_prev),
        .SDA(SDA),
        .enable(enable),
        .I2C_addr(correct_I2C_addr),
        .rst(rst),

        .done(done),
        .selected(selected)
    );

    // Initializing the clocks (remember FPGA_clk has to be faster than SCL)
    always #5 clk = ~clk;
    always #10 SCL = ~SCL;

    // Start of testbench
    initial begin

        $display("Starting Testbench!");

        // Hold reset true for a single clock
        @(posedge clk);
        rst = 1'b0;

        // Transmitting address frames (7 bits)
        for (int i = 6; i >= 0; i--) begin
            @(posedge SCL);
            SDA = incorrect_I2C_addr[i];
        end

        #20;
        $display("Testbench completed!");
        $finish;

    end

endmodule