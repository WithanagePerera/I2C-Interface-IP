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
    output logic SDA_down,
    output logic [NUM_BYTES-1:0] HEX_out [3:0]
);

    logic byte_count, bit_count;
    logic byte_en, bit_en;
    logic byte_rst, bit_rst;

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
        .received_data(received_data),
        .byte_en(byte_en),
        .bit_en(bit_en),
        .byte_rst(byte_rst),
        .bit_rst(bit_rst),
        .SDA_down(SDA_down)
    );

    // I need to map received data to our HEX outputs now.
    // This isn't a great approach since I'm hardcoding the indices, but I allowed for parameters.
    // I'll have to fix that in the future.
    assign HEX_out[0] = received_data[5][3:0];
    assign HEX_out[1] = received_data[4][3:0];
    assign HEX_out[2] = received_data[3][3:0];
    assign HEX_out[3] = received_data[2][3:0];
    assign HEX_out[4] = received_data[1][3:0];
    assign HEX_out[5] = received_data[0][3:0];

    // Keeps track of which byte we're on
    counter #(.WIDTH(NUM_BYTES)) byte_counter (
        .FPGA_clk(FPGA_clk),
        .enable(byte_en),
        .rst(byte_rst || rst),

        .count(byte_count)
    );

    // Keeps track of which bit we're on
    counter #(.WIDTH(8)) bit_counter (
        .FPGA_clk(FPGA_clk),
        .enable(bit_en),
        .rst(bit_rst || rst),

        .count(bit_count)
    );

endmodule