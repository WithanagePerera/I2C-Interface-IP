// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// Package to contain a custom enum for states for the address decoder FSM.

package address_decoder_states;

typedef enum bit {

    IDLE        = 1'b0, // Waits for rising edge SCL
    COMPARISON  = 1'b1  // Compares the SDA bit against the current I2C Address bit

} address_states;

endpackage