/* LED Flasher. Flashes LEDs from left to right
 * N = 				number of LEDs, default = 8
 * LED_DIVIDER = 	highest value of div, used for setting reg size. 
 * DIVIDER = 		number of periods between LED changes, (e.g. for 1/2 of clock frequency, put 2).
 * 					default is 1Hz for 50MHz clk, so value is 50 000 000. Sets the maximum amount of bits
 * clk = 			clock signal 
 * rst = 			asynchronous reset
 * outLED = 		LED output.
 */

module led_flasher
    #(parameter N = 8, parameter DIV_BUS = 32, parameter DIVIDER = 50_000_000)
    (input logic clk, input logic rst, output logic[N-1:0] outLED);

    logic divided_clock;		//1Hz Signal
    logic incr;         		//determines whether led's are decreasing (left to right)
										 //or decreasing (right to left).
	
								
    //instantiate 1Hz Clock
    freq_divider #(.DIV_BUS(DIV_BUS)) 
    led_flash_divider (	.inclk(clk),
								.outclk(divided_clock),
								.rst(rst),
								.div(DIVIDER));
	 
	 
	 always_ff @(posedge divided_clock, posedge rst) begin
		if(rst) begin
			incr <= 1'b0;
			outLED[N-1:0] <= 'b1000 ;
		end
		else begin
			//led at LED7, switch direction to LED6
			if(outLED[N-1]) begin
				incr <= 1'b0;
				outLED[N-1:N-2] <= 2'b01;
			end
			//led at LED0, switch direction to LED1
			else if (outLED[0]) begin
				incr <= 1'b1;
				outLED[1:0] <= 2'b10;
			end
			//increment or decrement LED per second. 
			else outLED <= incr ? outLED << 1 : outLED >> 1;
		end 

	end		
endmodule