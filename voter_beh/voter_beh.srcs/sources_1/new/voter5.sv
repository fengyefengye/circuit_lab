module voter5 (
    input logic I0, I1, I2, I3, I4,
    output logic led
);

    always_comb begin
        case ({I4, I3, I2, I1, I0})
            5'b00000: led = 0;
            5'b00001: led = 0;
            5'b00010: led = 0;
            5'b00011: led = 0;
            5'b00100: led = 0;
            5'b00101: led = 0;
            5'b00110: led = 0;
            5'b00111: led = 1;
            5'b01000: led = 0;
            5'b01001: led = 0;
            5'b01010: led = 0;
            5'b01011: led = 1;
            5'b01100: led = 0;
            5'b01101: led = 1;
            5'b01110: led = 1;
            5'b01111: led = 1;
            5'b10000: led = 0;
            5'b10001: led = 0;
            5'b10010: led = 0;
            5'b10011: led = 1;
            5'b10100: led = 0;
            5'b10101: led = 1;
            5'b10110: led = 1;
            5'b10111: led = 1;
            5'b11000: led = 0;
            5'b11001: led = 1;
            5'b11010: led = 1;
            5'b11011: led = 1;
            5'b11100: led = 1;
            5'b11101: led = 1;
            5'b11110: led = 1;
            5'b11111: led = 1;
            default : led = 0;
        endcase
    end

endmodule