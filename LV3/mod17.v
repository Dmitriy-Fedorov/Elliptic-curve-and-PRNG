//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dmitriy Fedorov
// 
// Create Date:    01:28:20 11/28/2017 
// Design Name: 
// Module Name:    mod17 
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
`timescale 1ns / 1ps
`define dataWidth 64
module mod17(
	input wire[`dataWidth-1:0] in,
	output reg[`dataWidth-1:0] out
    );

reg [63:0] div;

always@(*)
begin
	if(in[`dataWidth-1]==1)
	begin
		// modulo of negative number
		div = (~in+1)/17;
		out = 17-((~in+1)-div*17);
	end
	else
	begin
		// modulo of positive number
		div = in/17;
		out = in-div*17;
	end
end
endmodule
