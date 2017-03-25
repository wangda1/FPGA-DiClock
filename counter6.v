`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:29:51 03/15/2017 
// Design Name: 
// Module Name:    counter10 
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
module counter6(clk,ncr,en,out);		
	input clk,ncr,en;				//ncr异步清零,en使能信号
	output[3:0] out;
	
	reg[3:0] count;
	always@(posedge clk or negedge ncr)
	begin
		if(!ncr)
			count <= 0;
		else if((count == 3'd5)&&en)
			count <= 0;
		else if(en)
			begin
				if(count == 3'd5)
					count <= 0;
				else
					count <= count + 1'b1;
			end
		else
			count <= count;
	end		
	assign out = count;

endmodule
