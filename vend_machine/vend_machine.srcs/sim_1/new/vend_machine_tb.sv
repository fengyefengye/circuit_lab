`define CLK_PERIOD 10
module vend_machine_tb();

    logic sys_clk, sys_rst_n, open, coin5, coin10;
    logic [7 : 0]    an;
    logic [7 : 0]    a_to_g;
    
    vend dut(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .coin5(coin5),
        .coin10(coin10),
        .an(an),
        .a_to_g(a_to_g),
        .open(open)
    );
    
    // init
    initial begin
        sys_clk = 0;
        sys_rst_n = 0;
        coin5 = 0;
        coin10 = 0;
        #100;
        sys_rst_n = 1;
    end
    
    // generate sys_clk
    always #(`CLK_PERIOD / 2) sys_clk = ~sys_clk;
    
    // signal
    initial begin
        @(posedge sys_rst_n);
        $display("Reset is completed at  %t", $time);
        repeat (150) begin
            @(posedge sys_clk);
        end
        
        // press coin5
        #100;
        coin5 = 1;
        #300;
        coin5 = 0;
        
        // press coin10
        #100;
        coin10 = 1;
        #300;
        coin10 = 0;
        
        repeat (600) begin
            @(posedge sys_clk);
        end
        
        // press coin5 * 3
        repeat (3) begin
            #100;
            coin5 = 1;
            #300;
            coin5 = 0;
        end
        
        repeat (600) begin
            @(posedge sys_clk);
        end
        
        // press coin10 * 3
        repeat (3) begin
            #100;
            coin10 = 1;
            #300;
            coin10 = 0;
        end
        
        repeat (600) begin
            @(posedge sys_clk);
        end
        
        $stop;
    end
    
//    initial begin
//        $timeformat(-9, 0, "ns", 5);
//        $monitor("Time: %t, sys_rst_n = %b, i_start = %b, an = %b, a_to_g = %b", $time, sys_rst_n, i_start, an, a_to_g);
//    end


endmodule