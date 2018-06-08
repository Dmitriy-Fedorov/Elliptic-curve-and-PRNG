`timescale 1ns / 1ps
`define dataWidth 256
module SplitMix256(
	input wire [`dataWidth-1:0] aaa,
	input wire clk,
	output wire [`dataWidth-1:0] out
    );
wire [`dataWidth/4-1:0] a0,a1,a2,a3;

assign out = {a0,a1,a2,a3};

SplitMix64 v0_63(
	.aaa( aaa[`dataWidth/4-1:0] ),
	.clk(clk),
	.out(a0)
);

SplitMix64 v64_127(
	.aaa(aaa[`dataWidth/2-1:`dataWidth/4]),
	.clk(clk),
	.out(a1)
);

SplitMix64 v128_191(
	.aaa(aaa[`dataWidth*3/4-1:`dataWidth/2]),
	.clk(clk),
	.out(a2)
);

SplitMix64 v192_255(
	.aaa(aaa[`dataWidth-1:`dataWidth*3/4]),
	.clk(clk),
	.out(a3)
);
endmodule
