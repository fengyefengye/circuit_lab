
module x7seg_scan(
    input sys_clk,
    input sys_rst_n,
    input x7seg_clk,
    input [7 : 0] price_bcd,
    input [7 : 0] change_bcd,
    output [7 : 0] an,
    output [7 : 0] a_to_g
);

    logic[3 : 0] display_bits;
    
    x7seg_scan_part scanner(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .price_bcd(price_bcd),
        .change_bcd(change_bcd),
        .x7seg_clk(x7seg_clk), 
        .an(an),
        .display_bits(display_bits)
    );
        
    x7seg_num_part displayer(.D(display_bits), .a_to_g(a_to_g));

endmodule