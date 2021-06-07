module x7seg_a( input [3:0] D, input [7:0] SW, output logic [3:0] led, output logic [6:0] a_to_g, output logic [7:0] an );
always_comb begin
    an = SW; 
    led = D; 
    case(D) 
        4'h0: a_to_g = 7'b0000001; 
        4'h1: a_to_g = 7'b1001111; 
        4'h2: a_to_g = 7'b0010010; 
        4'h3: a_to_g = 7'b0000110; 
        4'h4: a_to_g = 7'b1001100; 
        4'h5: a_to_g = 7'b0100100; 
        4'h6: a_to_g = 7'b0100000; 
        4'h7: a_to_g = 7'b0001111; 
        4'h8: a_to_g = 7'b0000000; 
        4'h9: a_to_g = 7'b0000100; 
        4'hA: a_to_g = 7'b0001000; 
        4'hB: a_to_g = 7'b1100000; 
    endcase
endmodule