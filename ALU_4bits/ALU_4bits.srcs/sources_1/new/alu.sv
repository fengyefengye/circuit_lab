module alu (
    input [3 : 0]           A,
    input [3 : 0]           B,
    input [3 : 0]           aluop,
    output logic [7 : 0]    alures,
    output logic            ZF,
    output logic            OF
);
    
    localparam AND  = 4'b0000;
    localparam OR   = 4'b0001;
    localparam XOR  = 4'b0010;
    localparam NAND = 4'b0011;
    localparam NOT  = 4'b0100;
    localparam SLL  = 4'b0101;
    localparam SRL  = 4'b0110;
    localparam SRA  = 4'b0111;
    localparam MULU = 4'b1000;
    localparam MUL  = 4'b1001;
    localparam ADD  = 4'b1010;
    localparam ADDU = 4'b1011;
    localparam SUB  = 4'b1100;
    localparam SUBU = 4'b1101;
    localparam SLT  = 4'b1110;
    localparam SLTU = 4'b1111;

    logic sub, cout;
    logic [3 : 0] B_mux, S, res0, res1;
    logic [3 : 0] pa, pb;
    logic [7 : 0] mulout;
    
    assign pa = (A[3])? (~A + 1'b1) : A;
    assign pb = (B[3])? (~B + 1'b1) : B;
    assign mulout = pa * pb;

    
//    assign res1 = 4'b0000; 

    assign sub = (aluop == SUB | aluop == SUBU | aluop == SLT | aluop == SLTU) ? 1'b1 : 1'b0;
    assign B_mux = (aluop == SUB | aluop == SUBU | aluop == SLT | aluop == SLTU) ? ~B : B;

    always_comb begin
//    always@(*) begin
        res1 = 4'b0000;

        case(aluop)
            ADD, ADDU, SUB, SUBU    : res0 = S;
            AND                     : res0 = A & B;
            OR                      : res0 = A | B;
            XOR                     : res0 = A ^ B;
            NAND                    : res0 = ~(A & B);
            NOT                     : res0 = ~A;
            SLL                     : res0 = A << B[1 : 0];
            SRL                     : res0 = A >> B[1 : 0];
            SRA                     : res0 = $signed(A) >>> B[1 : 0];
            MUL                     : {res1, res0} = (A[3] ^ B[3]) ? (~mulout + 1'b1): mulout;
            MULU                    : {res1, res0} = A * B;
            SLT                     : begin
                                    if({A[3], B[3]} == 2'b10) res0 = 4'b0001;
                                    else if({A[3], B[3]} == 2'b01) res0 = 4'b0000;
                                    else begin
                                        if(S[3]) res0 = 4'b0001;
                                        else res0 = 4'b0000;
                                    end
            end
            SLTU                    : begin
                                    if(S > A) res0 = 4'b0001;
                                    else res0 = 4'b0000;
            end
            default                 : res0 = 4'b0000;

        endcase
    end
    
    always_comb begin
//    always@(*) begin    
//        res1 = 4'b0000;
        
        if (!{res1, res0}) ZF = 1'b1;
        else ZF = 1'b0;
        
        case(aluop)
            ADD : begin
                if(((!A[3] && !B_mux[3]) && S[3]) || ((A[3] && B_mux[3]) && (!S[3])) ) OF = 1'b1;
                else OF = 1'b0;
            end
            SUB : begin
                if(((!A[3] && !B_mux[3]) && S[3]) || ((A[3] && B_mux[3]) && (!S[3])) ) OF = 1'b1;
                else OF = 1'b0;
            end
            default : OF = 1'b0;
        endcase
    end
    
    rca U2(.A(A), .B(B_mux), .Cin(sub), .S(S), .Cout(cout));
    
    assign alures = {res1, res0};

endmodule