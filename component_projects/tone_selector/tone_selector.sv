/* Tone selector module
 * input switches - switch input, sw1-3 control pitch, sw0 control on/off
 * input clk - clock signal
 * output out - output tone
 * WARNING - Parameters changed for ease of simulation. 
 */

module tone_selector
#(  parameter DO = 32'd1,
    parameter RE = 32'd2,
    parameter MI = 32'd3,
    parameter FA = 32'd4,
    parameter SO = 32'd5,
    parameter LA = 32'd6,
    parameter TI = 32'd7,
    parameter DO2 = 32'd8)
(   input logic [3:0] switches,
    input logic clk,
    input logic rst,
    output logic out);

    logic div_out;
    logic [32:0] freq_sel;

    //feed appropriate select / DIVIDER into frequency divider
    
    always_comb begin
	case(switches[3:1])
		3'd0: freq_sel = DO;
		3'd1: freq_sel = RE;
		3'd2: freq_sel = MI;
		3'd3: freq_sel = FA;
		3'd4: freq_sel = SO;
		3'd5: freq_sel = LA;
		3'd6: freq_sel = TI;
		3'd7: freq_sel = DO2;
		default: freq_sel = {32{1'bx}};
	endcase
    end

    //instantiate frequency divider

    freq_divider #(.DIV_BUS(32)) tone_gen(.inclk(clk), 
														.outclk(div_out), 
														.rst(rst), 
														.div(freq_sel[32:0]));

    //set on off switch
    assign out = ~switches[0] ? 1'b0 : div_out;
	 
	 //no glitches. Purely combinational, and freq_divider has registered output (glitch free). 
endmodule


