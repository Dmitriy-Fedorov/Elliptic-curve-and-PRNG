`timescale 1ns / 1ps
`define dataWidth 64
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:21:28 11/27/2017
// Design Name:   eliptic
// Module Name:   /media/dmitriy/Main/GDrive/Dropbox/5th/DICD_project/xoroshiro128/TB.v
// Project Name:  xoroshiro128
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: eliptic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB;
	reg[`dataWidth-1:0] X_in,Y_in/*,GX,GY,a,b,n,p*/;
	wire[`dataWidth-1:0] X_out,Y_out;
	reg reset, clk;
	// Instantiate the Unit Under Test (UUT)
	eliptic uut (
	//.GeneratorX(GX),	
	//.GeneratorY(GY),
	//.a(a), .b(b),			
	//.n(n), 			
	//.p(p), 							 
	.clk(clk),						
	.reset(reset),
	.X_in(X_in),
	.Y_in(Y_in),
	.X_out(X_out),
	.Y_out(Y_out)
	);
	// a=2 b=2 p=17 n=19 h=1 G(5,1)
	initial
	begin
	    clk = 0;
	    forever
		 begin
		     clk = ~clk;
			  #10;
		 end
	end
	
	initial 
	begin
		reset = 1;
		/*GX = 5;
		GY = 1;
		a = 2;
		b = 2;
		p = 17;
		n = 19;*/
		
		// Wait 100 ns for global reset to finish
		#95;
		reset = 0;
		repeat(18)
		begin
			@(posedge clk);
			@(posedge clk);
			$display($time,,,"X: %d, Y: %d",X_out,Y_out);
		end
		
	end
	
	always@(posedge clk)
	begin
		X_in <= X_out;
		Y_in <= Y_out;
		
		//$display($time,,,"X: %d, Y: %d",X_out%17,Y_out%17);
   end
endmodule

