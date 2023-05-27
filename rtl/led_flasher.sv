/* LED Flasher. Flashes LEDs from left to right
 * N = 				number of LEDs, default = 8
 * LED_DIVIDER = 	highest value of div, used for setting reg size. 
 * div = 			number of periods between LED changes, (e.g. for 1/2 of clock frequency, put 2).
 * 					default is 1Hz for 50MHz clk, so value is 50 000 000. Sets the maximum amount of bits
 * clk = 			clock signal 
 * rst = 			asynchronous reset
 * outLED = 		LED output.
 */

module led_flasher
    #(parameter N = 8, parameter LED_DIVIDER = 50_000_000)
    (input logic clk, input logic rst, output logic [N-1:0] outLED);

    logic divided_clock;
    logic decr;         //determines whether led's are decreasing (left to right)
                        //or decreasing (right to left)

    //instantiate 1Hz Clock
    freq_divider #(.MAX_DIVIDER(LED_DIVIDER)) 
    led_flash_divider (.inclk(clk), .outclk(divided_clock), .rst(rst), .div(LED_DIVIDER));
    

    //state machine to determine which LED illuminates
    always_ff @(posedge divided_clock, posedge rst) begin
        if (rst) begin
            decr <= 1'b0;
            outLED[N-1:0] <= 2'b100;
        end
        else begin
            if(outLED[0]) begin
                decr <= 1'b0;
                outLED[1:0] <= 2'b10;
            end
            else if (outLED[N-1]) begin
                decr <= 1'b1;
                outLED[N-1:N-2] <= 2'b01;
            end
            else outLED[N-1:0] <= decr ? outLED[N-1:0] >> 1 : outLED[N-1:0] << 1;
        end
    end


endmodule