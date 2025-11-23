// Author: Withanage Perera
// November 2025
// I2C Interface IP Project

// This is a package I'm defining to contain a custom enum for states for the address decoder.


package address_decoder_states;

typedef enum bit {
    IDLE = 1'b0,
    COMPARISON = 1'b1
} address_states;

endpackage