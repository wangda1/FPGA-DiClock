`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:38 03/22/2017 
// Design Name: 
// Module Name:    Trans24To12 
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
module Trans24To12(Hour24,ncr,Hour12);
	input[7:0] Hour24;
	input ncr;
	
	output reg[7:0] Hour12;
	
	always@(Hour24)
	begin
		if(!ncr)
			Hour12 = 8'b0000_0000;
		else if(Hour24 < 8'd19)
			Hour12 = Hour24;
		else
				case(Hour24)
/*
					8'b0000_0000:{HexH,HexL} <= 8'b0000_0000;
					8'b0000_0001:{HexH,HexL} <= 8'b0000_0001;
					8'b0000_0010:{HexH,HexL} <= 8'b0000_0010;
					8'b0000_0011:{HexH,HexL} <= 8'b0000_0011;
					8'b0000_0100:{HexH,HexL} <= 8'b0000_0100;
					8'b0000_0101:{HexH,HexL} <= 8'b0000_0101;
					8'b0000_0110:{HexH,HexL} <= 8'b0000_0110;
					8'b0000_0111:{HexH,HexL} <= 8'b0000_0111;
					8'b0000_1000:{HexH,HexL} <= 8'b0000_1000;
					8'b0000_1001:{HexH,HexL} <= 8'b0000_1001;
					8'b0001_0000:{HexH,HexL} <= 8'b0001_0000;
					8'b0001_0001:{HexH,HexL} <= 8'b0001_0001;
					8'b0001_0010:{HexH,HexL} <= 8'b0001_0010;
*/		
					8'b0001_0011:Hour12 = 8'b0000_0001;
					8'b0001_0100:Hour12 = 8'b0000_0010;
					8'b0001_0101:Hour12 = 8'b0000_0011;
					8'b0001_0110:Hour12 = 8'b0000_0100;
					8'b0001_0111:Hour12 = 8'b0000_0101;
					8'b0001_1000:Hour12 = 8'b0000_0110;
					8'b0001_1001:Hour12 = 8'b0000_0111;
					8'b0010_0000:Hour12 = 8'b0000_1000;
					8'b0010_0001:Hour12 = 8'b0000_1001;
					8'b0010_0010:Hour12 = 8'b0001_0000;
					8'b0010_0011:Hour12 = 8'b0001_0001;
					8'b0010_0100:Hour12 = 8'b0001_0010;
				endcase
	end
endmodule
