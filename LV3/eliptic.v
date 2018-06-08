`timescale 1ns / 1ps
`define dataWidth 64
`define romWidth 10
`define dataDepth 8
module eliptic(
	input wire clk,	
	input wire reset,
	// a=2 b=2 p=17 n=19 h=1 G(5,1) G(6,3) G(10,6) (3,1)
	input wire [`dataWidth-1:0] X_in,Y_in,
	output reg [`dataWidth-1:0] X_out, Y_out 
    );
reg [`dataWidth-1:0] GeneratorX,GeneratorY;
reg [`dataWidth-1:0] a/*, b*/;
initial
begin
	a = `dataWidth'd2;
	//b = `dataWidth'd2;
	GeneratorX = `dataWidth'd5;
	GeneratorY = `dataWidth'd1;
end
reg phase;
always@(*)
begin
	if (counter == 0 | counter == 1)
		phase = 'b0;
	else
		phase = 'b1;
end	

reg [`dataWidth-1:0] counter;
reg [`dataWidth-1:0] s/*,X_out_,Y_out_*/;
wire [`dataWidth-1:0] ResultX, ResultY,ResultX_temp,ResultY_temp,ss,ss_17,ssp,ssp_17;
wire [`dataWidth/2-1:0] s_3xx_a,s_2y,s_inv_Gx_Rx;
wire[`dataWidth-1:0] s_2y_17,s_Gx_Rx,s_Gx_Rx_17,s_Gy_Ry,s_Gy_Ry_17; //denominator
always @(posedge clk)
begin
	if(reset==1)
		begin
			X_out <= GeneratorX;
			Y_out <= GeneratorY;
			counter <= 'd0;
		end
	else
		begin
			X_out <= ResultX;
			Y_out <= ResultY;
			counter <= counter + 'd1;
		end
end

/***********************************************************************/
assign s_3xx_a = (3*GeneratorX*GeneratorX + a);
//assign s_2y = GeneratorY * 'd2; 
mod17 ss__(
	.in(GeneratorY * 'd2), //denominator
	.out(s_2y_17)
    );
ROM_imod17 count1(
	.readAddress(s_2y_17),
	//.clk(clk),
	.data(s_2y)
	);
assign ss = s_3xx_a * s_2y;
mod17 ss_(
	.in(ss),
	.out(ss_17)
    );
/***********************************************************************/

assign s_Gy_Ry = GeneratorY - Y_in;
assign s_Gx_Rx = GeneratorX - X_in;
mod17 ss_3(
	.in(s_Gy_Ry), //numerator
	.out(s_Gy_Ry_17)
    );
mod17 ss_2(
	.in(s_Gx_Rx), //denominator
	.out(s_Gx_Rx_17)
    );
ROM_imod17 count_plus(
	.readAddress(s_Gx_Rx_17),
	//.clk(clk),
	.data(s_inv_Gx_Rx)
	);
assign ssp = s_inv_Gx_Rx * s_Gy_Ry_17;
mod17 ss_1(
	.in(ssp),
	.out(ssp_17)
    );
/***********************************************************************/
always@(*)
begin
	if(~phase)
		begin
			s <= ss_17;
		end
	else
		begin
			s <= ssp_17;
		end
end
/***********************************************************************/
assign ResultX_temp = s*s - (GeneratorX + X_in);
mod17 ResultXXXXX(
	.in(ResultX_temp),
	.out(ResultX)
    );
assign ResultY_temp = s*(GeneratorX-ResultX)-GeneratorY;
mod17 ResultYYYYY(
	.in(ResultY_temp),
	.out(ResultY)
    );	 
endmodule 