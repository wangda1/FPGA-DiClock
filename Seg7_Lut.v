`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:52 03/19/2017 
// Design Name: 
// Module Name:    Seg7_Lut 
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
module Seg7_Lut(in,out);
	input[3:0] in;
	output reg[6:0]out;
	
	always@(in)
		begin
			case(in)					//gfedcba π≤“ı ˝¬Îπ‹;
				4'h1:out = 7'b111_1001;
				4'h2:out = 7'b010_0100;
				4'h3:out = 7'b011_0000;
				4'h4:out = 7'b001_1001;
				4'h5:out = 7'b001_0010;
				4'h6:out = 7'b000_0010;
				4'h7:out = 7'b111_1000;
				4'h8:out = 7'b000_0000;
				4'h9:out = 7'b001_0000;
				4'ha:out = 7'b000_1000;
				4'hb:out = 7'b000_0011;
				4'hc:out = 7'b100_0110;
				4'hd:out = 7'b010_0001;
				4'he:out = 7'b000_0110;
				4'hf:out = 7'b000_1110;
				4'h0:out = 7'b100_0000;
			endcase
		end
endmodule
