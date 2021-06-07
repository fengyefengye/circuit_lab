module dec_74LS139 (
    input logic S, D1, D0,
    output logic Y0, Y1, Y2, Y3
);

    always_comb begin
        case ({S, D1, D0})
            3'b000:     {Y3, Y2, Y1, Y0} = 4'b1110;
            3'b001:     {Y3, Y2, Y1, Y0} = 4'b1101;
            3'b010:     {Y3, Y2, Y1, Y0} = 4'b1011;
            3'b011:     {Y3, Y2, Y1, Y0} = 4'b0111;
            default:    {Y3, Y2, Y1, Y0} = 4'b1111;
        endcase
    end

endmodule