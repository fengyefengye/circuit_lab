`define SIM
module x7seg_d(
    input sys_clk,
    input sys_rst_n,
    input [15 : 0] i_data,
    output [7 : 0] an,
    output [7 : 0] a_to_g
);

    localparam SYS_CLK_FREQ = 100_000_000;
    
    `ifdef SIM
        localparam TARGET_CLK_FREQ = 10_000_000;
    `else
        localparam TARGET_CLK_FREQ = 1000;
    `endif
    
    localparam CNT_MAX = SYS_CLK_FREQ / TARGET_CLK_FREQ;
    localparam CSCNT_MAX = 4;

    int r_cnt;
    logic clk;
    logic [1 : 0] cs_cnt;
    logic [7 : 0] q;
    logic [3 : 0] x7seg_data;
    
    // signal: r_cnt
    always_ff @ (posedge sys_clk) begin
        if(!sys_rst_n) r_cnt <= 0;
        else if (r_cnt == CNT_MAX - 1) r_cnt <= 0;
        else r_cnt <= r_cnt + 1;
    end
    
    // signal: clk
    always_ff @ (posedge sys_clk) begin
        if(!sys_rst_n) clk <= 1'b0;
        else if(r_cnt == CNT_MAX - 1) clk <= 1'b1;
        else clk <= 1'b0;
    end
    
    // signal: cs_cnt
    always_ff @ (posedge sys_clk) begin
        if(!sys_rst_n) cs_cnt <= 2'b0;
        else begin
            if(clk) begin
                if(cs_cnt == CSCNT_MAX - 1) cs_cnt <= 2'b0;
                else cs_cnt <= cs_cnt + 1;
            end
            else cs_cnt <= cs_cnt;
        end
    end
    
    // signal: an
    always_ff @ (posedge sys_clk) begin
        if(!sys_rst_n) q <= 8'b1111_1111;
        else if(cs_cnt == 0) begin
            q[0] <= 1'b0;
            q[1] <= 1'b1;
            q[2] <= 1'b1;
            q[3] <= 1'b1;
        end
        else if(cs_cnt == 1) begin
            q[0] <= 1'b1;
            q[1] <= 1'b0;
            q[2] <= 1'b1;
            q[3] <= 1'b1;
        end
        else if(cs_cnt == 2) begin
            q[0] <= 1'b1;
            q[1] <= 1'b1;
            q[2] <= 1'b0;
            q[3] <= 1'b1;
        end
        else if(cs_cnt == 3) begin
            q[0] <= 1'b1;
            q[1] <= 1'b1;
            q[2] <= 1'b1;
            q[3] <= 1'b0;
        end
        else q <= 8'b1111_1111;
    end

    assign an = q;

    always_comb begin
        case (i_data)
            4'h0: a_to_g = 7'b0000001; 
            4'h1: a_to_g = 7'b1001111; 
            4'h2: a_to_g = 7'b0010010; 
            4'h3: a_to_g = 7'b0000110; 
            4'h4: a_to_g = 7'b1001100; 
            4'h5: a_to_g = 7'b0100100; 
            4'h6: a_to_g = 7'b0100000; 
            4'h7: a_to_g = 7'b0001111; 
            4'h8: a_to_g = 7'b0000000; 
            4'h9: a_to_g = 7'b0000100; 
            4'hA: a_to_g = 7'b0001000; 
            4'hB: a_to_g = 7'b1100000; 
        endcase
    end

endmodule