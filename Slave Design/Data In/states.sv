// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Package to contain a custom enum for states for the "data in" FSM.

package data_in_states;

    typedef enum bit[1:0] {
        IDLE        = 2'b00,
        RECORD      = 2'b01,
        ACKNOWLEDGE = 2'b10,
        STOP        = 2'b11
    } states;

endpackage