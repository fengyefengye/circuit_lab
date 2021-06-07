`timescale 1ns / 1ps

module dig_clock(
    input                   sys_clk,
    input                   sys_rst_n,
    input                   i_start,
    output logic [7 : 0]    an,
    output logic [7 : 0]    a_to_g
    );
    
    logic en_clk;
    logic [7 : 0] sec_bin;
    logic [7 : 0] min_bin;
    logic [7 : 0] sec_bcd;
    logic [7 : 0] min_bcd;
    
    time_counter time_counter_m(.sys_clk(sys_clk), .sys_rst_n(sys_rst_n),
        .i_start(i_start), .en_clk(en_clk), .min(min_bin), .sec(sec_bin));
        
    bin2bcd_0 bin2bcd_sec(.bin(sec_bin), .bcd(sec_bcd));
    
    bin2bcd_0 bin2bcd_min(.bin(min_bin), .bcd(min_bcd));
    
    x7seg_scan x7seg_scan_m(.sys_clk(sys_clk), .sys_rst_n(sys_rst_n), 
        .en_clk(en_clk), .sec_bcd(sec_bcd), .min_bcd(min_bcd), 
        .an(an), .a_to_g(a_to_g));
    
endmodule
