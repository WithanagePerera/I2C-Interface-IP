// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Basic testbench for the address decoder unit. I'll test using an invalid address, then a matching address.

`timescale 1ns/1ps

module address_decoder_tb;

    logic clk, SCL, SCL_prev, SDA, enable, rst;
    logic done, selected;

    logic [6:0] correct_I2C_addr = 7'b0001000;
    logic [6:0] incorrect_I2C_addr = 7'b0000111; // I'll use this one during testing to validate if my design correctly distinguishes correct from incorrect addresses
    
    // Setting initial values
    initial begin
        clk = 1'b0;
        SCL = 1'b0;
        SDA = 1'b1;
        enable = 1'b1;
        rst = 1'b1;
    end

    always_ff @(posedge clk) begin
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

        // Transmitting address frames (7 bits) for the INCORRECT address
        for (int i = 6; i >= 0; i--) begin
            
            // Update SDA on SCL rising edges
            @(posedge SCL);
            SDA <= incorrect_I2C_addr[i];

            // Check if done is asserted assuming this is the invalid bit
            if (incorrect_I2C_addr[i] != correct_I2C_addr[i]) begin
               
                // Wait for the next rising edge of FPGA_clk since the controller's state transitions are based on FPGA_clk
                @(posedge clk);
                #1;
                
                // Controller correctly identified that the SDA bit doesn't match the correct address bit
                if (done == 1'b1 && selected == 1'b0) begin
                    $display("[%0t] Correctly identified the invalid address for bit_num=%0d, incorrect address bit=%0d while correct address bit=%0d", $time, i, incorrect_I2C_addr[i], correct_I2C_addr[i]);
                    break;

                // Correctly identified SDA bit doesn't match, but wrongly asserted selected
                end else if (done == 1'b1 && selected == 1'b1) begin
                    $display("[%0t] Correctly identified the invalid address for bit_num=%0d, incorrect address bit=%0d while correct address bit=%0d", $time, i, incorrect_I2C_addr[i], correct_I2C_addr[i]);
                    $display("HOWEVER, selected is true (it should be false)");
                    break;

                // Controller did NOT identify that the SDA bit doesn't match the correct address bit
                end else
                    $display("[%0t] ERROR! Controller did not assert done for bit_num=%0d, incorrect address bit=%0d while correct address bit=%0d", $time, i, incorrect_I2C_addr[i], correct_I2C_addr[i]);

            end

        end

        // Reset our states
        #10;
        rst = 1'b1;
        enable = 1'b0;
        repeat (2) @(posedge clk);
        rst = 1'b0;
        enable = 1'b1;

        // Transmitting address frames (7 bits) for the CORRECT address
        for (int i = 6; i >= 0; i--) begin
            
            // Update SDA on SCL rising edges
            @(posedge SCL);
            SDA <= correct_I2C_addr[i];

            @(posedge clk);
            #1;

            // End of the loop
            if (i == 0) begin
                // Controller correctly identified the address is correct
                if (done == 1'b1 && selected == 1'b1) begin
                    $display("[%0t] Correctly identified the invalid address for bit_num=%0d, incorrect address bit=%0d while correct address bit=%0d", $time, i, incorrect_I2C_addr[i], correct_I2C_addr[i]);
                    break;
                
                // Controller identified address is correct, BUT selected is not asserted
                end else if (done == 1'b1 && selected == 1'b0) begin
                    $display("[%0t] Correctly asserted done, BUT selected wasn't asserted!", $time);
                    break;

                // Controller did NOT identify that the address was correct
                end else
                    $display("[%0t] ERROR! Controller did not assert done when the received address matched the correct address", $time);
            end
        end

	@(negedge SCL);
        $display("Testbench completed!");
        $finish;

    end

endmodule
