`define CLK_PERIOD 10
module dig_clock_tb();

    logic sys_clk, sys_rst_n, i_start;
    logic [7 : 0]    an;
    logic [7 : 0]    a_to_g;
    
    dig_clock dut(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .i_start(i_start),
        .an(an),
        .a_to_g(a_to_g)
    );
    
    // init
    initial begin
        sys_clk = 0;
        sys_rst_n = 0;
        i_start = 0;
        #100;
        sys_rst_n = 1;
        #100;
        i_start = 1;
        #500;
        i_start = 0;
    end
    
    // generate sys_clk
    always #(`CLK_PERIOD / 2) sys_clk = ~sys_clk;
    
    // signal
    initial begin
        @(posedge sys_rst_n);
        $display("Reset is completed at  %t", $time);
        repeat (360) begin
            @(posedge sys_clk);
        end
        #100;
        i_start = 1;
        #500;
        i_start = 0;
        repeat (120) begin
            @(posedge sys_clk);
        end
        $stop;
    end
    
    initial begin
        $timeformat(-9, 0, "ns", 5);
        $monitor("Time: %t, sys_rst_n = %b, i_start = %b, an = %b, a_to_g = %b", $time, sys_rst_n, i_start, an, a_to_g);
    end


endmodule