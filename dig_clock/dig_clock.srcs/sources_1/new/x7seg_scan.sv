
module x7seg_scan(
    input sys_clk,
    input sys_rst_n,
    input en_clk,
    input [7 : 0] sec_bcd,
    input [7 : 0] min_bcd,
    output [7 : 0] an,
    output [7 : 0] a_to_g
);

    logic[3 : 0] display_bits;
    
    x7seg_scan_part scanner(.sys_clk(sys_clk), .sys_rst_n(sys_rst_n),
        .sec_bcd(sec_bcd), .min_bcd(min_bcd), .en_clk(en_clk), 
        .an(an), .display_bits(display_bits));
        
    x7seg_num_part displayer(.D(display_bits), .a_to_g(a_to_g));

endmodule