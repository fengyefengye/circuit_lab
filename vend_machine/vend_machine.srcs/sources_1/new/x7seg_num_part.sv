module x7seg_num_part (
    input [3 : 0] D,
    output logic [7 : 0] a_to_g
    );
    
    always_comb begin
        case(D)
            4'b0000:   a_to_g = 8'b11000000;  
            4'b0001:   a_to_g = 8'b11111001;  
            4'b0010:   a_to_g = 8'b10100100;  
            4'b0011:   a_to_g = 8'b10110000;  
            4'b0100:   a_to_g = 8'b10011001;  
            4'b0101:   a_to_g = 8'b10010010;  
            4'b0110:   a_to_g = 8'b10000010;  
            4'b0111:   a_to_g = 8'b11011000;  
            4'b1000:   a_to_g = 8'b10000000;  
            4'b1001:   a_to_g = 8'b10010000;
            default :  a_to_g = 8'b11000000;
        endcase
    end
    
    
endmodule