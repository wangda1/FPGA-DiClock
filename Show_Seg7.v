`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:43:16 03/22/2017 
// Design Name: 
// Module Name:    Show_Seg7 
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
module Show_Seg7(Hex0,Hex1,Hex2,Hex3,clk_50M,ncr,Show,AN0,AN1,AN2,AN3);
	input[6:0] Hex0,Hex1,Hex2,Hex3;
	input clk_50M;
	input ncr;
	
	output reg AN0,AN1,AN2,AN3;
	output reg[6:0]Show;
	
	wire clk_100;
//----------------·ÖÆµ---------------------
Divider100 D1(clk_50M,ncr,clk_100);

	always@(posedge clk_100 or negedge ncr)
	begin
		if(!ncr)
			begin{AN0,AN1,AN2,AN3} <= 4'b0111;Show <= Hex0;end
		else if({AN0,AN1,AN2,AN3} == 4'b0111)
			begin{AN0,AN1,AN2,AN3} <= 4'b1011;Show <= Hex1;end
		else if({AN0,AN1,AN2,AN3} == 4'b1011)
			begin{AN0,AN1,AN2,AN3} <= 4'b1101;Show <= Hex2;end
		else if({AN0,AN1,AN2,AN3} == 4'b1101)
			begin{AN0,AN1,AN2,AN3} <= 4'b1110;Show <= Hex3;end
		else
			begin{AN0,AN1,AN2,AN3} <= 4'b0111;Show <= Hex0;end

	end

endmodule
