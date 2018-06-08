`timescale 1ns / 1ps
`define dataWidth 64
module xorshift64(
	input wire [`dataWidth-1:0] seed1,
	input wire [`dataWidth-1:0] seed2,
	input wire clk,
	input wire set,
	output reg [`dataWidth-1:0] result
);

reg [`dataWidth-1:0] now_state0;
reg [`dataWidth-1:0] now_state1;

wire [`dataWidth-1:0] next_state0;
wire [`dataWidth-1:0] next_state1;

assign next_state0 = now_state0;
assign next_state1 = now_state1^now_state0^(now_state1 >> 18)^(now_state0 >> 5);

always @(posedge clk)
begin	
	if (set == 1)
		begin
			now_state0 <= seed2;
			now_state1 <= seed1;
			result <= seed1 + seed2;
		end
	else
		begin
			result <= now_state0 + now_state1;
			now_state0 <= next_state0;
			now_state1 <= next_state1;
		end
end
endmodule