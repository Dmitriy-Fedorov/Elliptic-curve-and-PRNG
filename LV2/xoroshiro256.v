`timescale 1ns / 1ps
`define dataWidth 256
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dmitriy Fedorov
// 
// Create Date:    22:32:55 11/12/2017 
// Design Name: 
// Module Name:    xoroshiro256 
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
module xoroshiro256(
	input wire [`dataWidth-1:0] seed1,
	input wire [`dataWidth-1:0] seed2,
	input wire clk,
	input wire set,
	output wire [`dataWidth-1:0] result
    );
wire [`dataWidth/4-1:0] a0,a1,a2,a3;

assign result = {a0,a1,a2,a3};

xoroshiro128 v0_63(
	.seed1( seed1[`dataWidth/4-1:0] ),
	.seed2( seed2[`dataWidth/4-1:0] ),
	.clk(clk),
	.set(set),
	.result(a0)
);

xoroshiro128 v64_127(
	.seed1(seed1[`dataWidth/2-1:`dataWidth/4]),
	.seed2(seed2[`dataWidth/2-1:`dataWidth/4]),
	.clk(clk),
	.set(set),
	.result(a1)
);

xoroshiro128 v128_191(
	.seed1(seed1[`dataWidth*3/4-1:`dataWidth/2]),
	.seed2(seed2[`dataWidth*3/4-1:`dataWidth/2]),
	.clk(clk),
	.set(set),
	.result(a2)
);

xoroshiro128 v192_255(
	.seed1(seed1[`dataWidth-1:`dataWidth*3/4]),
	.seed2(seed2[`dataWidth-1:`dataWidth*3/4]),
	.clk(clk),
	.set(set),
	.result(a3)
);
endmodule
