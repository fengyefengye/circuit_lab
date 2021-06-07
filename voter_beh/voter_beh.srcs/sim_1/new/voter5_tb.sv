`timescale 1ns/1ns
module voter5_tb ();

    logic I4, I3, I2, I1, I0, led;
    voter5 dut(.I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .led(led));
    initial begin
        {I4, I3, I2, I1, I0} = 5'b00000;
        #10;
        for(int i = 1; i < 32; i = i + 1) begin
            {I4, I3, I2, I1, I0} = i[4 : 0];
            #10;
        end
        $finish;
    end
    initial begin
        $monitor($time, "::I4 = %b, I3 = %b, I2 = %b, I1 = %b, I0 = %b, led = %b", I4, I3, I2, I1, I0, led);
    end

endmodule