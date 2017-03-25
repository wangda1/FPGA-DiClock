`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:58:49 03/15/2017 
// Design Name: 
// Module Name:    Divider50MHz 
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
module Divider50MHz(clk_50M,ncr,clk_1);
	input clk_50M,ncr;
	output clk_1;
	reg clk_1;
	
	parameter N=25;
	parameter CLK=50000000;
	
	reg[N-1:0] count;
	
	always@(posedge clk_50M or negedge ncr)
	begin
		if(!ncr)
			begin count <= 25'd0;clk_1 <= 1'd0;end
		else if(count == CLK/2-1)
			begin count <= 25'd0;clk_1 <= ~clk_1;end
		else
			count <= count + 1'b1;
	end
	
endmodule
