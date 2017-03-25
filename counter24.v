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
module counter24(clk,ncr,en,outH,outL);		
	input clk,ncr,en;				//ncr异步清零,en使能信号
	output outH,outL;
	reg[3:0] outH;
	reg[3:0] outL;
	
	always@(posedge clk or negedge ncr)
	begin
		if(!ncr)
			{outH,outL} <= 8'd0;
		else if(!en)
			{outH,outL} <= {outH,outL};
		else if((outH>4'd2)||(outL>4'd9)||((outH==4'd2)&&(outL>4'd3)))
			{outH,outL} <= 8'd0;
		else if((outH==4'd2)&&(outL==4'd3))
			{outH,outL} <= 8'd0;
		else if((outH==4'd2)&&(outL<4'd3))
			begin outH <= outH;outL <= outL + 1'b1;end
		else if(outL==4'd9)
			begin outH <= outH + 1'b1;outL <= 4'd0;end
		else
			begin outH <= outH;outL <= outL + 1'b1;end
	end

endmodule
