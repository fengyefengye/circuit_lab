module voter5_ic (
    input logic I4, I3, I2, I1, I0,
    output logic led
);
    logic by0, by1, by2, by3;
    logic y00, y01, y02, y03, y04, y05, y06, y07;
    logic y10, y11, y12, y13, y14, y15, y16, y17;
    logic y20, y21, y22, y23, y24, y25, y26, y27;
    logic y30, y31, y32, y33, y34, y35, y36, y37;
    dec_74LS139 mid(.S(1'b0), .D1(I1), .D0(I0),
        .Y0(by0), .Y1(by1), .Y2(by2), .Y3(by3));
    dec_74LS138 pos0(.G(1'b1), .G2_a(1'b0), .G2_b(by0), .D0(I2), .D1(I3), .D2(I4),
        .Y0(y00), .Y1(y01), .Y2(y02), .Y3(y03), .Y4(y04), .Y5(y05), .Y6(y06), .Y7(y07));
    dec_74LS138 pos1(.G(1'b1), .G2_a(1'b0), .G2_b(by1), .D0(I2), .D1(I3), .D2(I4),
        .Y0(y10), .Y1(y11), .Y2(y12), .Y3(y13), .Y4(y14), .Y5(y15), .Y6(y16), .Y7(y17));
    dec_74LS138 pos2(.G(1'b1), .G2_a(1'b0), .G2_b(by2), .D0(I2), .D1(I3), .D2(I4),
        .Y0(y20), .Y1(y21), .Y2(y22), .Y3(y23), .Y4(y24), .Y5(y25), .Y6(y26), .Y7(y27));
    dec_74LS138 pos3(.G(1'b1), .G2_a(1'b0), .G2_b(by3), .D0(I2), .D1(I3), .D2(I4),
        .Y0(y30), .Y1(y31), .Y2(y32), .Y3(y33), .Y4(y34), .Y5(y35), .Y6(y36), .Y7(y37));
    assign led = ~(y07 & y13 & y15 & y16 & y17 & y23 & y25 & y26 & y27
                    & y31 & y32 & y33 & y34 & y35 & y36 & y37);

endmodule
