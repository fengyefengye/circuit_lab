//`define SIM
module en_clk_generator(
    input                   sys_clk,
    input                   sys_rst_n,
    output logic            debouncing_clk,
    output logic            timecnt_clk,
    output logic            x7seg_clk
    );

    localparam SYS_CLK_FREQ = 100_000_000;

    `ifdef SIM
        localparam TARGET_CNT_CLK_FREQ = 10_000_000;
        localparam TARGET_DEBOUNCE_CLK_FREQ = 10_000_000;
        localparam TARGET_X7SEG_CLK_FREQ = 10_000_000;
    `else
        localparam TARGET_CNT_CLK_FREQ = 25_000_000;
        localparam TARGET_DEBOUNCE_CLK_FREQ = 100;
        localparam TARGET_X7SEG_CLK_FREQ = 1000;
    `endif

    localparam DEBOUNCE_CNT_MAX = SYS_CLK_FREQ / TARGET_DEBOUNCE_CLK_FREQ;
    localparam TIMECNT_MAX = SYS_CLK_FREQ / TARGET_CNT_CLK_FREQ;
    localparam X7SEG_CNT_MAX = SYS_CLK_FREQ / TARGET_X7SEG_CLK_FREQ;

    int debouncing_cnt, time_cnt, seg_cnt;

    // debouncing_cnt
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) debouncing_cnt <= 0;
        else if (debouncing_cnt == DEBOUNCE_CNT_MAX - 1) debouncing_cnt <= 0;
        else debouncing_cnt <= debouncing_cnt + 1;
    end
    
    // time_cnt
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) time_cnt <= 0;
        else if(time_cnt == TIMECNT_MAX - 1) time_cnt <= 0;
        else time_cnt <= time_cnt + 1;
    end
    
    // seg_cnt
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) seg_cnt <= 0;
        else if(seg_cnt == X7SEG_CNT_MAX - 1) seg_cnt <= 0;
        else seg_cnt <= seg_cnt + 1;
    end
    
    // debouncing_clk
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) debouncing_clk <= 1'b0;
        else if (debouncing_cnt == DEBOUNCE_CNT_MAX - 1) debouncing_clk <= 1'b1;
        else debouncing_clk <= 1'b0;
    end
    
    // timecnt_clk
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) timecnt_clk <= 1'b0;
        else if (time_cnt == TIMECNT_MAX - 1) timecnt_clk <= 1'b1;
        else timecnt_clk <= 1'b0;
    end
    
    // x7seg_clk
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) x7seg_clk <= 1'b0;
        else if (seg_cnt == X7SEG_CNT_MAX - 1) x7seg_clk <= 1'b1;
        else x7seg_clk <= 1'b0;
    end
    
endmodule