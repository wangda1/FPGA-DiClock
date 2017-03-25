`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:34:22 03/22/2017 
// Design Name: 
// Module Name:    Divider100 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Divider100(clk_50M,ncr,clk_100);
	input clk_50M,ncr;
	output reg clk_100;
	
	reg[15:0] count;
	always@(posedge clk_50M or negedge ncr)
	begin
		if(!ncr)
			begin count <= 16'd0;clk_100 <= 0;end
		else if(count == 16'd62499)
			begin count <= 16'd0;clk_100 <= ~clk_100;end
		else
			count <= count +1'b1;
	end
endmodule
