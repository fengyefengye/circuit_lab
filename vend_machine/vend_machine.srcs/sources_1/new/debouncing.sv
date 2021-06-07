module debouncing (
    input       sys_clk,
    input       sys_rst_n,
    input 		debouncing_clk,
    input		i_btn,
    output logic	o_btn
    );

    logic [2 : 0] delay_q;

    always_ff @( posedge sys_clk ) begin
        if(!sys_rst_n) delay_q <= 3'b000;
        else if(debouncing_clk) delay_q <= {delay_q[1], delay_q[0], i_btn};
        else delay_q <= delay_q;
    end

    assign o_btn = &delay_q;

    
endmodule