// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

module counter (
    input logic FPGA_clk,
    input logic enable,
    input logic rst,

    output logic [2:0] count
);

    logic [2:0] next_count_r;

    // Updating count
    always_ff @(posedge FPGA_clk or posedge rst) begin

        if (rst)
            count <= '0;
        else
            count <= next_count_r;

    end

    // Next count logic
    always_comb begin

        if (enable == 1'b1)
            next_count_r <= count + 1;
        else
            next_count_r <= count;

    end

endmodule