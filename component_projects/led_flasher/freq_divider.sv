/*
 * Frequency divider
 * inclk - 			input clock signal
 * outclk - 		divided clock signal
 * DIV_BUS	 - 	Sets bus size for div. Recommended to 32, since built in adder only works to 32 bits. 
 * div - 			How many times it is divided (e.g. for 1/2 the clock frequency, put 2.)
 * 					default to 1_000_000, 50Hz for 50MHz clk. 
 * Works for all 32 bit DIVIDER values
 */
 
module freq_divider
	#(parameter DIV_BUS = 32)
	(input logic inclk, input logic rst, input logic [DIV_BUS - 1:0] div, output logic outclk);
	
	//instantiate counter to correct size.
	logic [DIV_BUS - 1:0] counter;
	
	//sequential FF logic
	always_ff @(posedge inclk, posedge rst) begin
		if(rst) begin
			counter <= 'b0;
		end
		else begin
			//increment counter per clock cycle
			counter <= counter + 'd1;
			
			//if counter filled to divider, reset.
			if (counter >= div - 'd1) 	counter <= 'b0;
			
			//for first half of cycle, set to one, then set to 0. 
			if(counter < (div >> 1)) 	outclk <= 1'b1;
			else 								outclk <= 1'b0;
		end
	end
	
//no glitches since no comb logic after seqn logic. 
	
endmodule