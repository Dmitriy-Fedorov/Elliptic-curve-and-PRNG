`timescale 1ns / 1ps
`define dataWidth 256
module xorshift256(
	input wire [`dataWidth-1:0] seed1,
	input wire [`dataWidth-1:0] seed2,
	input wire clk,
	input wire set,
	output wire [`dataWidth-1:0] result
    );
wire [`dataWidth/4-1:0] a0,a1,a2,a3;

assign result = {a0,a1,a2,a3};

xorshift64 v0_63(
	.seed1( seed1[`dataWidth/4-1:0] ),
	.seed2( seed2[`dataWidth/4-1:0] ),
	.clk(clk),
	.set(set),
	.result(a0)
);

xorshift64 v64_127(
	.seed1(seed1[`dataWidth/2-1:`dataWidth/4]),
	.seed2(seed2[`dataWidth/2-1:`dataWidth/4]),
	.clk(clk),
	.set(set),
	.result(a1)
);

xorshift64 v128_191(
	.seed1(seed1[`dataWidth*3/4-1:`dataWidth/2]),
	.seed2(seed2[`dataWidth*3/4-1:`dataWidth/2]),
	.clk(clk),
	.set(set),
	.result(a2)
);

xorshift64 v192_255(
	.seed1(seed1[`dataWidth-1:`dataWidth*3/4]),
	.seed2(seed2[`dataWidth-1:`dataWidth*3/4]),
	.clk(clk),
	.set(set),
	.result(a3)
);
endmodule