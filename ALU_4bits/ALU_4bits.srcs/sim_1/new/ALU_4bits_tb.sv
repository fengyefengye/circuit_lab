`timescale 1ns/1ns
module alu_tb();
    logic[3 : 0] A, B, aluop;
    logic[7 : 0] alures, exp_alures;
    logic ZF, OF, exp_ZF, exp_OF;
    logic[21 : 0] stim[56 : 0];
    alu foo(.A(A), .B(B), .aluop(aluop), .alures(alures), .ZF(ZF), .OF(OF));
    
    initial begin
        $readmemb("alu_tb_vec.txt", stim);
        for(int i = 0; i < 57; i = i + 1) begin
            {aluop, A, B, exp_alures, exp_ZF, exp_OF} = stim[i];    #10;
            if(alures == exp_alures && ZF == exp_ZF && OF == exp_OF) $display($time, "test pass!");
            else $display($time, "Error: inputs = %b, %b, %b, output = %b", A, B, aluop, alures);
        end
        $finish;
    end

endmodule