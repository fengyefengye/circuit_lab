`define CLK_PERIOD 10
module wf_led_tb();

    logic clk, rst_n;
    logic [15 : 0] led_out;
    
    wf_led dut(.sys_clk(clk), .sys_rst_n(rst_n), .led_out(led_out));
    
    initial begin
        clk <= 1'b0;
        rst_n <= 1'b0;
        #100;
        rst_n <= 1'b1;
    end
    
    always #(`CLK_PERIOD/2) clk = ~clk;
    
    initial begin
        @(posedge rst_n);
        repeat (320) begin
            @(posedge clk);
        end
        
       $finish;
    end
    

endmodule