`timescale 1ns / 1ps
`define dataWidth 64

module SplitMix64(
	input wire [`dataWidth-1:0] aaa,
	input wire clk,
	output reg [`dataWidth-1:0] out
);

wire[`dataWidth-1:0] aaa1,aaa2,aaa3,aaa4;

assign aaa1 = aaa + 'h9e3779b97f4a7c15;
assign aaa2 = aaa1^(aaa1 >> 30) * 'hbf58476d1ce4e5b9;
assign aaa3 = aaa2^(aaa2 >> 27) * 'h94d049bb133111eb;
assign aaa4 = aaa3^(aaa3 >> 31);

always@(posedge clk)
begin	
	out <= aaa4;
end
endmodule
