//`define SIM
module time_cnt (
    input           sys_clk,
    input           sys_rst_n,
    input           timecnt_clk,
    input           posedge_flag,
    output[7 : 0]   min,
    output[7 : 0]   sec
    );
    
    `ifdef SIM
        localparam CNT_MAX = 3;
        localparam SEC_MAX = 5;
        localparam MIN_MAX = 5;
    `else
        localparam CNT_MAX = 25_000_000;
        localparam SEC_MAX = 60;
        localparam MIN_MAX = 60;
    `endif
    
    int sec_cnt;
    logic running_flag;
    logic [7 : 0] seconds;
    logic [7 : 0] minutes;
    
    // running_flag
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) running_flag <= 1'b0;
        else if(posedge_flag) running_flag <= !running_flag;
        else running_flag <= running_flag;
    end
    
    // sec_cnt
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) sec_cnt <= 0;
        else if(running_flag & timecnt_clk) begin
            if(sec_cnt == CNT_MAX - 1) sec_cnt <= 0;
            else sec_cnt <= sec_cnt + 1;
        end
        else sec_cnt <= sec_cnt;
    end
    
    // seconds and minutes
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) begin
            seconds <= 8'b0000_0000;
            minutes <= 8'b0000_0000;
        end
        else if(running_flag & timecnt_clk) begin
            if(sec_cnt == CNT_MAX - 1) begin
                if(seconds == SEC_MAX - 1) begin
                    seconds <= 8'b0000_0000;
                    if(minutes == MIN_MAX - 1) minutes <= 8'b0000_0000;
                    else minutes <= minutes + 1;
                end
                else seconds <= seconds + 1;
            end
            else seconds <= seconds;
        end
        else seconds <= seconds;
    end
    
//    // minutes
//    always_ff @(posedge sys_clk) begin
//        if(!sys_rst_n) minutes <= 8'b0000_0000;
//        else if(running_flag & timecnt_clk) begin
//            if(seconds == SEC_MAX - 1) begin
//                if(minutes == MIN_MAX - 1) minutes <= 8'b0000_0000;
//                else minutes <= minutes + 1;
//            end
//            else minutes <= minutes;
//        end
//        else minutes <= minutes;
//    end
    
    assign sec = seconds;
    assign min = minutes;
    
endmodule