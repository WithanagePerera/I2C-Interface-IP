// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Generic counter implementation. I'll use it to count which bit of the I2C address I should be comparing the current SDA bit against.

module counter #(
    parameter int WIDTH
)
(
    input logic FPGA_clk,
    input logic enable,
    input logic rst,

    output logic [WIDTH-1:0] count
);

    // Updating count
    always_ff @(posedge FPGA_clk or posedge rst) begin

        if (rst)
            count <= '0;
        else if (enable)
            count <= count + 'd1;
        else
            count <= count;
    end

endmodule