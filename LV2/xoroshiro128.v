`timescale 1ns / 1ps
`define dataWidth 64
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dmitriy Fedorov
// 
// Create Date:    20:08:14 11/12/2017 
// Design Name: 
// Module Name:    xoroshiro128 
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
module xoroshiro128(
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
wire [`dataWidth-1:0] rot_s0_55;


wire [`dataWidth-1:0] s1;
assign s1 = now_state0 ^ now_state1;
assign rot_s0_55 = (now_state0 << 55)|(now_state0 >> `dataWidth-55);
assign next_state0 = rot_s0_55 ^ s1 ^ (s1 << 14);
assign next_state1 = ((s1 << 36)|(s1 >> `dataWidth-36));

always @(posedge clk)
begin
	if (set == 1)
		begin
		now_state0 <= seed1;
		now_state1 <= seed2;
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