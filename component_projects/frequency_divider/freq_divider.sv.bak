/*
 * Frequency divider
 * inclk - 			input clock signal
 * outclk - 		divided clock signal
 * MAX_DIVIDER - 	Sets maximum of div to select register size
 * div - 			How many times it is divided (e.g. for 1/2 the clock frequency, put 2.)
 * 					default to 1_000_000, 50Hz for 50MHz clk. 
 * Works for all 32 bit DIVIDER values
 */
 
module freq_divider
	#(parameter MAX_DIVIDER = 50_000_000)
	(input logic inclk, input logic rst, input logic [clogb2(MAX_DIVIDER) - 1:0] div, output logic outclk);
	
	//calculate counter size necessary. Borrowed from Verilog_2001_changes.pdf slides. 
	function integer clogb2;
		input [31:0] depth;
		begin
			for(clogb2 = 0; depth > 0; clogb2 = clogb2 + 1)
				depth = depth >> 1;
		end
	endfunction
	
	//instantiate counter to correct size.
	logic [clogb2(MAX_DIVIDER) - 1:0] counter;
	
	//sequential FF logic
	always_ff @(posedge inclk, posedge rst) begin
		if(rst) begin
			counter <= 'b0;
		end
		else begin
			//increment counter per clock cycle
			counter <= counter + 'd1;
			
			//if counter filled to divider, reset.
			if (counter > div) 			counter <= 'b0;
			
			//for first half of cycle, set to one, then set to 0. 
			if(counter < (div >> 1)) 		outclk <= 1'b1;
			else 									outclk <= 1'b0;
		end
	end
	
endmodule
		