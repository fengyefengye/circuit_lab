module edge_det (
    input       sys_clk,
    input       sys_rst_n,
    input		i_btn,
    output logic	posedge_flag
    );

    logic [1 : 0] q;
    always_ff @( posedge sys_clk ) begin
        if(!sys_rst_n) q <= 2'b00;
        else q <= {q[0], i_btn};
    end

    assign posedge_flag = q[0] &(~q[1]);

    
endmodule
