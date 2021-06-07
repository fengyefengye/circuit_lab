module vend_fsm(
    input sys_clk, sys_rst_n,
    input coin5_flag, coin10_flag,
    input timeout,
    output logic timecnt_running_flag,
    output logic open,
    output logic [7 : 0] change_bin,
    output logic [7 : 0] price_bin
);

    localparam S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

    // signal
    logic [2 : 0] current_state, next_state;

    // step1: state switch
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) current_state <= S0;
        else current_state <= next_state;
    end
    
    // step2: caculate next state & timecnt_running_flag
    always_comb begin
        case(current_state)
            S0: begin
                if(coin5_flag) next_state = S1;
                else if(coin10_flag) next_state = S2;
                else next_state = S0;
            end
            S1: begin
                if(coin5_flag) next_state = S2;
                else if(coin10_flag) next_state = S3;
                else next_state = S1;
            end
            S2: begin
                if(coin5_flag) next_state = S3;
                else if(coin10_flag) next_state = S4;
                else next_state = S2;
            end
            S3: begin
                if(timeout) next_state = S0;
                else next_state = S3;
            end
            S4: begin
                if(timeout) next_state = S0;
                else next_state = S4;
            end
            default: next_state = S0;
        endcase
    end
    
    // step3: output
    always_ff @(posedge sys_clk) begin
        if(!sys_rst_n) begin
            open <= 1'b0;
            change_bin <= 0;
            price_bin <= 0;
            timecnt_running_flag <= 1'b0;
        end
        else begin
            if(current_state == S0) begin
                open <= 1'b0;
                change_bin <= 0;
                price_bin <= 0;
                timecnt_running_flag <= 1'b0;
            end
            else if(current_state == S1) begin
                open <= 1'b0;
                change_bin <= 0;
                price_bin <= 5;
                timecnt_running_flag <= 1'b0;
            end
            else if(current_state == S2) begin
                open <= 1'b0;
                change_bin <= 0;
                price_bin <= 10;
                timecnt_running_flag <= 1'b0;
            end
            else if(current_state == S3) begin
                open <= 1'b1;
                change_bin <= 0;
                price_bin <= 15;
                timecnt_running_flag <= 1'b1;
            end
            else if(current_state == S4) begin
                open <= 1'b1;
                change_bin <= 5;
                price_bin <= 20;
                timecnt_running_flag <= 1'b1;
            end
            else begin
                open <= 1'b0;
                change_bin <= 0;
                price_bin <= 0;
                timecnt_running_flag <= 1'b0;
            end
        end
    end

endmodule