// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Controller for the Data In component (handles data coming from the master)

import data_in_states::*;

module data_in_controller #(
    parameter int NUM_BYTES = 6
)
(
    input logic FPGA_clk,
    input logic SCL,
    input logic SCL_prev,
    input logic SDA,
    input logic SDA_prev,
    input logic enable,
    input logic [$clog2(NUM_BYTES):0] byte_count,
    input logic [2:0] bit_count,
    input logic rst,
    
    output logic done,
    output logic [7:0] received_data [NUM_BYTES-1:0],
    output logic byte_en,
    output logic bit_en,
    output logic byte_rst,
    output logic bit_rst,
    output logic SDA_down
);

    states current_state_r, next_state_r;

    // I need an internal set of registers/RAM for storing the data we receive
    logic [7:0] received_data_r [NUM_BYTES-1:0];

    // Updating states
    always_ff @(posedge FPGA_clk or posedge rst) begin

        if (rst == 1'b1) begin
            current_state_r <= IDLE;

            for (int x = 0; x < NUM_BYTES; x++) begin
                received_data[x] <= '0;
            end
            
        end else begin
            current_state_r <= next_state_r;
            received_data <= received_data_r;
        end
    end

    // Next state logic + control signals
    always_comb begin

        next_state_r <= IDLE;

        done <= 1'b0;
        byte_en <= 1'b0;
        bit_en <= 1'b0;
        byte_rst <= 1'b0;
        bit_rst <= 1'b0;
        SDA_down <= 1'b0;

        case (current_state_r)
            
            IDLE: begin

                // Rising edge SCL
                if ((SCL && !SCL_prev) && enable)
                    next_state_r <= RECORD;

                // Falling edge SCL
                // else if ((!SCL && SCL_prev) && enable)
                //     next_state_r <= ACKNOWLEDGE;

                else
                    next_state_r <= IDLE;

            end
            
            RECORD: begin
                
                if (bit_count == 'd7) begin
		    byte_en <= 1'b1;
                    next_state_r <= ACKNOWLEDGE;
                end else
                    next_state_r <= IDLE;
                
                    received_data_r[byte_count][7-bit_count] <= SDA;
                bit_en <= 1'b1;

                // We need to reset the byte count before we reach the max value of the byte counter. Why?
                // Consider if I only want to store 6 bytes -> count value of 5. Byte counter has a max value of 7
                // for 3 bits so we'd overflow and access the wrong indices of the inferred RAM/registers. 
                if (byte_count == (NUM_BYTES - 1))
                    byte_rst <= 1'b1;

            end

            ACKNOWLEDGE: begin

                SDA_down <= 1'b1;

                if (~SCL && SCL_prev)
                    next_state_r <= STOP;
                else
                    next_state_r <= ACKNOWLEDGE;

            end

            STOP: begin

                // Falling edge SCL
                if (~SCL && SCL_prev)
                    next_state_r <= RECORD;

                // SCL rises before SDA (STOP condition)
                else if (SCL && ~SDA_prev && SDA)
                    done <= 1'b1;

                // No activity yet
                else
                    next_state_r <= STOP;

            end

            default: ;
        endcase

        if (rst == 1'b1)
            for (int x = 0; x < NUM_BYTES; x++) begin
                received_data_r[x] <= '0;
            end

    end

endmodule
