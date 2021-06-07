module input_ctrl(
    input sys_clk,
    input sys_rst_n,
    input debouncing_clk,
    input coin5,
    input coin10,
    output logic flag5,
    output logic flag10
);

    logic debouced_coin5, debouced_coin10;
    
    // debounce coin5
    debouncing debouncing_coin5(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .debouncing_clk(debouncing_clk),
        .i_btn(coin5),
        .o_btn(debouced_coin5)
    );
    
    // debounce coin10
    debouncing debouncing_coin10(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .debouncing_clk(debouncing_clk),
        .i_btn(coin10),
        .o_btn(debouced_coin10)
    );
    
    // detact edge coin5
    edge_det edge_det_coin5(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .i_btn(debouced_coin5),
        .posedge_flag(flag5)
    );
    
    // detact edge coin10
    edge_det edge_det_coin10(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .i_btn(debouced_coin10),
        .posedge_flag(flag10)
    );

endmodule