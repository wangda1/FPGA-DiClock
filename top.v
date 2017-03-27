`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:59:50 03/15/2017 
// Design Name: 
// Module Name:    top 
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
//	manual comments:
//	关于闹钟与时钟使用顺序:设置闹钟前 1.打开setAL 2.打开Adj_Min,Adj_Hour 设置完毕后:	1.关闭Adj_Min,Adj_Hour 2.关闭setAL
//							  设置时钟时 1.setAL关闭状态 2.2.打开Adj_Min,Adj_Hour
//	约束时:	所有按键都需要用拨码开关 数码管约束:gfedcba = Hex[6:0] Led高低位对应顺序不变
//
//////////////////////////////////////////////////////////////////////////////////
module top(clk_50,ncr,en,setAL,SwitchAL,Switch12,Adj_Min,Adj_Hour,Show,AN0,AN1,AN2,AN3,Led,Alarm,Clock_Led);  //秒信号通过LED显示出来，二进制

	input clk_50,ncr,en;						//ncr==0时有效，en == 1时有效
	input Adj_Min,Adj_Hour;					//=1时有效
	input setAL,SwitchAL;					//闹钟的设置与开关 setAL == 1时设置闹钟,SwitchAL == 1时，闹钟正常，==0时关闭蜂鸣
	input Switch12;
	
	output AN0,AN1,AN2,AN3;					//数码管的片选信号
	output wire[6:0] Show;					//数码管的输出信号
	output wire[7:0] Led;					//LED的输出信号
	output Alarm;								//闹钟的输出信号
	output Clock_Led;							//整点报时信号
	

	supply1 Vdd;       					//电源
	supply0 Gnd;		 					//地

	wire[6:0] Hex0,Hex1,Hex2,Hex3;
	wire[7:0] Hour,Minute,Second;			//时钟信号
	wire[7:0] AHour,AMinute;				//闹钟信号
	wire[7:0] Show_Minute,Show_Hour;    //数码管信号
	wire[7:0] Show_Hour12,Show_Hour24;  //12与24进制的小时信号
	wire MinL_En,MinH_En,Hour_En;			//时钟使能信号
	wire AL_Adj_Min,AL_Adj_Hour;			//闹钟使能信号
	
	wire clk_1;
	reg Clock_Led_En;     					//整点报时使能信号
	reg Clock_Led_Temp1;
	reg[5:0]Clock_Led_Cnt;					//整点报时计次信号
	wire Clock_Led_Temp;						//整点报时 时信号 
	
//----------------------------------------------分频--------------------------------------------------
Divider50MHz U0(.clk_50M(clk_50),
					 .ncr(ncr),
					 .clk_1(clk_1));	 
//----------------------------------------------计数-------------------------------------------------
//*************************秒*******************************
counter6 S1(clk_1,ncr,en,Second[7:4]);
counter10 S2(clk_1,ncr,en,Second[3:0]);

//*************************分*******************************
counter6 M1(clk_1,ncr,MinH_En,Minute[7:4]);
counter10 M2(clk_1,ncr,MinL_En,Minute[3:0]);

//*************************时*******************************
counter24 H(clk_1,ncr,Hour_En,Hour[7:4],Hour[3:0]);	

assign MinL_En = ((!setAL)&&Adj_Min)?Vdd:(Second==8'b0101_1001);
assign MinH_En = ((!setAL)&&Adj_Min)?(Minute[3:0]==4'd9):((Minute[3:0]==4'd9)&&(Second==8'b0101_1001));

assign Hour_En = ((!setAL)&&Adj_Hour)?Vdd:((Minute==8'b0101_1001)&&(Second==8'b0101_1001));
//----------------------------------------------整点报时-------------------------------------------------
//利用Hour_En信号来判断是否是整点,Show_Hour用来判断与Clock_Led_Cnt是否相同来表示闪的次数
always@(Show_Hour[5:4])
begin
	case(Show_Hour[5:4])
		2'b00:Clock_Led_Temp1 = 5'd0;
		2'b01:Clock_Led_Temp1 = 5'd10;
		2'b10:Clock_Led_Temp1 = 5'd20;
		default:Clock_Led_Temp1 = 5'd0;
	endcase
end

assign Clock_Led_Temp = Clock_Led_Temp1 + Show_Hour[3:0] + Clock_Led_Temp1 + Show_Hour[3:0];

always@(posedge clk_1)
begin
	if((!Adj_Min)&&(!Adj_Hour)&&(Hour_En))
		begin Clock_Led_En <= 1;Clock_Led_Cnt <= 6'd0;end
	else if(Clock_Led_Temp == Clock_Led_Cnt)
		begin Clock_Led_En <= 0;Clock_Led_Cnt <= 6'd0;end
	else
		begin Clock_Led_En <= Clock_Led_En;Clock_Led_Cnt <= Clock_Led_Cnt + 1'b1;end
end

assign Clock_Led = Clock_Led_En?Second[0]:Gnd;



//----------------------------------------------闹钟-----------------------------------------------------
//--------------判断闹钟setAL---------------
assign AL_Adj_Min = setAL && Adj_Min;	
assign AL_Adj_Hour =	setAL && Adj_Hour;		
AlarmClock AL1(clk_1,ncr,AL_Adj_Min,AL_Adj_Hour,AHour,AMinute);

assign Alarm = SwitchAL?((AHour == Hour)&&(AMinute == Minute)):Gnd;

//*****************数码管显示**************
assign Show_Minute = setAL?AMinute:Minute;
assign Show_Hour24 = setAL?AHour:Hour;

//*****************分钟译码****************
Seg7_Lut MinL(Show_Minute[3:0],Hex0);
Seg7_Lut MinH(Show_Minute[7:4],Hex1);

//----------------12与24之间转换-------------
Trans24To12 T12(Show_Hour24,ncr,Show_Hour12);

assign  Show_Hour= Switch12?Show_Hour12:Show_Hour24;
//*****************时的译码******************
Seg7_Lut HouL(Show_Hour[3:0],Hex2);
Seg7_Lut HouH(Show_Hour[7:4],Hex3);

Show_Seg7 S3(Hex0,Hex1,Hex2,Hex3,clk_50,ncr,Show,AN0,AN1,AN2,AN3);

assign Led = Second;

endmodule
