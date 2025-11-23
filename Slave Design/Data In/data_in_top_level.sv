// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Top-level file that implements the structural architecture of the "data in" component.

module data_in_top_level #(
    parameter int NUM_BYTES = 6
)
(
    input logic FPGA_clk,
    input logic SCL,
    input logic SCL_prev,
    input logic SDA,
    input logic SDA_prev,
    input logic enable,
    input logic rst,

    output logic done,
    output logic [NUM_BYTES-1:0] HEX_out [3:0]
);

    logic [NUM_BYTES-1:0] received_data [7:0];

    data_in_controller #(.NUM_BYTES(NUM_BYTES)) controller (
        .FPGA_clk(FPGA_clk),
        .SCL(SCL),
        .SCL_prev(SCL_prev),
        .SDA(SDA),
        .SDA_prev(SDA_prev),
        .enable(enable),
        .byte_count(byte_count),
        .bit_count(bit_count),
        .rst(rst),

        .done(done),
        .received_data(received_data)
    )

endmodule