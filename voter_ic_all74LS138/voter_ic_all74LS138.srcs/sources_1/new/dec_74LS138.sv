module dec_74LS138 (
    input logic G, G2_a, G2_b, D2, D1, D0,
    output logic Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7
);

    always_comb begin
        case ({G, G2_a, G2_b, D2, D1, D0})
            6'b100_000: {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1111_1110;
            6'b100_001: {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1111_1101;
            6'b100_010: {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1111_1011;
            6'b100_011: {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1111_0111;
            6'b100_100: {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1110_1111;
            6'b100_101: {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1101_1111;
            6'b100_110: {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1011_1111;
            6'b100_111: {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b0111_1111;
            default:    {Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0} = 8'b1111_1111;
        endcase
    end


endmodule