module time_counter(
    input                   sys_clk,
    input                   sys_rst_n,
    input                   i_start,
    output logic            en_clk,
    output logic [7 : 0]    min,
    output logic [7 : 0]    sec
);

    logic debouncing_clk, timecnt_clk;
    logic debouced_start, posedge_flag;

    en_clk_generator en_clk_generator_m(.sys_clk(sys_clk), .sys_rst_n(sys_rst_n), 
        .debouncing_clk(debouncing_clk), .timecnt_clk(timecnt_clk), .x7seg_clk(en_clk));

    debouncing debouncing_m(.sys_clk(sys_clk), .sys_rst_n(sys_rst_n), 
        .debouncing_clk(debouncing_clk), .i_btn(i_start), .o_btn(debouced_start));
    
    edge_det edge_det_m(.sys_clk(sys_clk), .sys_rst_n(sys_rst_n), 
        .i_btn(debouced_start), .posedge_flag(posedge_flag));
    
    time_cnt time_cnt_m(.sys_clk(sys_clk), .sys_rst_n(sys_rst_n), 
        .timecnt_clk(timecnt_clk), .posedge_flag(posedge_flag), .min(min), .sec(sec));

endmodule