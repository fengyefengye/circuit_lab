
module x7seg_scan_part (
    input sys_clk,
    input sys_rst_n,
    input x7seg_clk,
    input [7 : 0] price_bcd,
    input [7 : 0] change_bcd,
    output [7 : 0] an,
    output logic[3 : 0] display_bits
);

    localparam CSCNT_MAX = 4;

    logic [1 : 0] cs_cnt;
    logic [7 : 0] q;
        
    // signal: cs_cnt
    always_ff @ (posedge sys_clk) begin
        if(!sys_rst_n) cs_cnt <= 2'b00;
        else begin
            if(x7seg_clk) begin
                if(cs_cnt == CSCNT_MAX - 1) cs_cnt <= 2'b00;
                else cs_cnt <= cs_cnt + 1;
            end
            else cs_cnt <= cs_cnt;
        end
    end
    
    // signal: an
    always_ff @ (posedge sys_clk) begin
        if(!sys_rst_n) q <= 8'b1111_1111;
        else if(cs_cnt == 0) q <= 8'b1111_1110;
        else if(cs_cnt == 1) q <= 8'b1111_1101;
        else if(cs_cnt == 2) q <= 8'b1111_1011;
        else if(cs_cnt == 3) q <= 8'b1111_0111;
        else q <= 8'b1111_1111;
    end
    
    // signal: display_bits
    always_ff @ (posedge sys_clk) begin
        if(!sys_rst_n) display_bits <= 4'b0000;
        else begin
            case(cs_cnt)
                2'b00: display_bits <= price_bcd[3 : 0];
                2'b01: display_bits <= price_bcd[7 : 4];
                2'b10: display_bits <= change_bcd[3 : 0];
                2'b11: display_bits <= change_bcd[7 : 4];
            endcase
        end
    end

    assign an = q;


endmodule