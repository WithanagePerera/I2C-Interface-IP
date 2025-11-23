// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

import address_decoder_states::*;

module address_decoder_controller (
    input logic FPGA_clk,
    input logic SCL,
    input logic SCL_prev,
    input logic SDA,
    input logic enable,
    input logic [6:0] I2C_addr, // the unique address of this I2C slave, it's stored in a register
    input logic [2:0] bit_count, // tells me which address bit we should be comparing the SDA value against
    input logic rst,

    output logic done,
    output logic selected,
    output logic bit_count_enable,
    output logic bit_count_rst
);

    // State variables
    address_states current_state_r, next_state_r;

    // State logic
    always_ff @(posedge FPGA_clk or posedge rst) begin
        
        if (rst)
            current_state_r <= IDLE;
        else
            current_state_r <= next_state_r;
    end

    // Next state logic + conditional outputs
    always_comb begin

        case (current_state_r)

            IDLE: begin
               
                // Checking for rising edge of SCL
                if ((SCL && ~SCL_prev) && enable)
                    next_state_r <= COMPARISON;

            end

            COMPARISON: begin

                next_state_r <= IDLE;

                // Addr bit from SDA matches, we receive the 7th bit first
                if (I2C_addr[6 - bit_count] == SDA) begin

                    // We're on the last address bit that we need to compare
                    if (bit_count == 3'd6) begin

                        bit_count_rst <= 1'b1;
                        selected <= 1'b1;
                        done <= 1'b1;
                        
                    end else
                        bit_count_enable <= 1'b1;

                end else
                    done <= 1'b1;

            end

            default: begin
               
                next_state_r <= IDLE;

                done <= 1'b0;
                selected <= 1'b0;
                bit_count_enable <= 1'b0;
                bit_count_rst <= 1'b0;
                
            end

        endcase
    end

endmodule