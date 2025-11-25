// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Top-level file that implements the structural architecture of the address decoder

module address_decoder_top (
    input logic FPGA_clk,
    input logic SCL,
    input logic SCL_prev,
    input logic SDA,
    input logic enable,
    input logic [6:0] I2C_addr,
    input logic rst,

    output logic done,
    output logic selected
);

logic [2:0] bit_count;
logic bit_count_enable;

address_decoder_controller controller (
    .FPGA_clk(FPGA_clk),
    .SCL(SCL),
    .SCL_prev(SCL_prev),
    .SDA(SDA),
    .enable(enable),
    .I2C_addr(I2C_addr),
    .bit_count(bit_count),
    .rst(rst),

    .done(done),
    .selected(selected),
    .bit_count_enable(bit_count_enable)
);

counter #(.WIDTH(3)) bit_counter (
    .FPGA_clk(FPGA_clk),
    .enable(bit_count_enable),
    .rst(rst),

    .count(bit_count)
);

endmodule
