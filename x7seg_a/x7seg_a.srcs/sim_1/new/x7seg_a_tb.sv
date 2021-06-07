`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/29 14:37:55
// Design Name: 
// Module Name: x7seg_a_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module x7seg_a_tb( );

	logic [3 : 0] x;
	logic [6 : 0] a_to_g;

	integer i;

	x7seg_a DUT(.x(x), .a_to_g(a_to_g));

	initial begin

		for(i = 0; i < 16; i = i + 1) begin
			x = i;
			#20;
		end

	end

	initial begin
		$timeformat(-9, 0, "ns", 5);
		$monitor("At time %t: x = %b, a_to_g = %b", $time, x, a_to_g);
	end

endmodule
