`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:00:36 11/29/2017
// Design Name:   xorshift256
// Module Name:   /media/dmitriy/Main/GDrive/Dropbox/5th/DICD_project/LV1/testbench.v
// Project Name:  level1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: xorshift256
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

// Inputs
reg [255:0] s1,s2;
reg clk;
reg set;

// Outputs
wire [255:0] result,seed1,seed2;


initial
begin
	 clk = 0;
	 forever
	 begin
		  clk = ~clk;
		  #5;
	 end
end


initial begin
	// Initialize Inputs
	s1 = 256'h79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798;
	s2 = 256'h483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8;
	set = 1;
	// Wait 100 ns for global reset to finish
	#100;
	set = 0;  
	// Add stimulus here

end
// Instantiate the Unit Under Test (UUT)
xorshift256 uut (
	.seed1(seed1), 
	.seed2(seed2), 
	.clk(clk), 
	.set(set), 
	.result(result)
);

SplitMix256 gen1(
.aaa(s1),
.clk(clk),
.out(seed1));

SplitMix256 gen2(
.aaa(s2),
.clk(clk),
.out(seed2));

	
always @(posedge clk)
begin
	$display($time,,"%h",result);
end
endmodule

