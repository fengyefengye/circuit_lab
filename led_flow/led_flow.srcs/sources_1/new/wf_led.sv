`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/11 13:46:17
// Design Name: 
// Module Name: wf_led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wf_led(
    input sys_clk,
    input sys_rst_n,
    output [15 : 0] led_out
    );
    
    logic clk_flag;
    int r_cnt;
    logic [15 : 0] q;
    
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) r_cnt <= 0;
        else begin
//            if(r_cnt == 9) r_cnt <= 0;
            if(r_cnt == 49999999) r_cnt <= 0;
            else r_cnt <= r_cnt + 1;
        end
    end
    
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) clk_flag <= 0;
        else begin
            if(r_cnt == 49999999) clk_flag <= 1;
//            if(r_cnt == 9) clk_flag <= 1;
            else clk_flag <= 0;
        end
    end
    
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) q <= 16'b00000000_00000001;
        else begin
            if(clk_flag) q <= {q[14 : 0], q[15]};
            else q <= q;
        end
    end
    
    assign led_out = q;
    
endmodule
