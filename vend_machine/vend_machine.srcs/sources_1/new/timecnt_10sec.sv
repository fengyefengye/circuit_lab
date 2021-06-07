//`define SIM
module timecnt_10sec (
    input           sys_clk,
    input           sys_rst_n,
    input           timecnt_clk,
    input           running_flag,
    output logic    timeout
    );
    
    `ifdef SIM
        localparam CNT_MAX = 5;
        localparam SEC_MAX = 10;
    `else
        localparam CNT_MAX = 100_000_000;
        localparam SEC_MAX = 10;
    `endif
    
    int sec_cnt;
    logic [3 : 0] seconds;
    
    
    // sec_cnt
    always_ff @(posedge sys_clk) begin
        if((!sys_rst_n) | (!running_flag)) sec_cnt <= 0;
        else if(running_flag & timecnt_clk) begin
            if(sec_cnt == CNT_MAX - 1) sec_cnt <= 0;
            else sec_cnt <= sec_cnt + 1;
        end
        else sec_cnt <= sec_cnt;
    end
    
    // seconds
    always_ff @(posedge sys_clk) begin
        if((!sys_rst_n) | (!running_flag)) begin
            seconds <= 4'b0000;
            timeout <= 1'b0;
        end
        else if(running_flag & timecnt_clk) begin
            if(sec_cnt == CNT_MAX - 1) begin
                if(seconds == SEC_MAX - 1) begin
                    seconds <= 4'b0000;
                    timeout <= 1'b1;
                end
                else begin
                    seconds <= seconds + 1;
                    timeout <= 1'b0;
                end
            end
            else begin
                seconds <= seconds;
                timeout <= 1'b0;
            end
        end
        else begin
            seconds <= seconds;
            timeout <= 1'b0;
        end
    end
        
endmodule