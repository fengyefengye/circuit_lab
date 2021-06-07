`timescale 1ns / 1ps

module vend(
    input sys_clk, sys_rst_n,
    input coin5, coin10,
    output [7 : 0] an,
    output [7 : 0] a_to_g,
    output open
    );
    
    // wires
    logic debouncing_clk, timecnt_clk, x7seg_clk;
    logic coin5_flag, coin10_flag;
    logic timecnt_running_flag, timeout;
    logic [7 : 0] change_bin;
    logic [7 : 0] change_bcd;
    logic [7 : 0] price_bin;
    logic [7 : 0] price_bcd;
    
    // module: en_clk_generator
    en_clk_generator en_clk_generator_m(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .debouncing_clk(debouncing_clk),
        .timecnt_clk(timecnt_clk),
        .x7seg_clk(x7seg_clk)
    );
    
    // module: input_ctrl
    input_ctrl input_ctrl_m(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .debouncing_clk(debouncing_clk),
        .coin5(coin5),
        .coin10(coin10),
        .flag5(coin5_flag),
        .flag10(coin10_flag)
    );
    
    // module: timecnt_10sec
    timecnt_10sec timecnt_10sec_m(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .timecnt_clk(timecnt_clk),
        .running_flag(timecnt_running_flag),
        .timeout(timeout)
    );
    
    // module: vend_fsm
    vend_fsm vend_fsm_m(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .coin5_flag(coin5_flag),
        .coin10_flag(coin10_flag),
        .timeout(timeout),
        .timecnt_running_flag(timecnt_running_flag),
        .open(open),
        .change_bin(change_bin),
        .price_bin(price_bin)
    );
    
    // module: bin2bcd_change
    bin2bcd_0 bin2bcd_change (
      .bin(change_bin),  // input wire [7 : 0] bin
      .bcd(change_bcd)  // output wire [7 : 0] bcd
    );
    
    // module: bin2bcd_price
    bin2bcd_0 bin2bcd_price (
      .bin(price_bin),  // input wire [7 : 0] bin
      .bcd(price_bcd)  // output wire [7 : 0] bcd
    );
    
    // module: x7sega_scan
    x7seg_scan x7seg_scan_m(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .x7seg_clk(x7seg_clk),
        .change_bcd(change_bcd),
        .price_bcd(price_bcd), 
        .an(an),
        .a_to_g(a_to_g)
    );
    
endmodule