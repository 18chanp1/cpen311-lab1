/* Tone selector module
 * input switches - switch input, sw1-3 control pitch, sw0 control on/off
 * input clk - clock signal
 * output out - output tone
 * WARNING: Parameters changed for simulation, as it would take too long to simulate
 */

module tone_selector
#(  parameter DO = 26'd1,
    parameter RE = 26'd2,
    parameter MI = 26'd3,
    parameter FA = 26'd4,
    parameter SO = 26'd5,
    parameter LA = 26'd6,
    parameter TI = 26'd8,
    parameter DO2 = 26'd8)
(   input logic [3:0] switches,
    input logic clk,
    input logic rst,
    output logic out);

    logic div_out;
    logic [25:0] freq_sel;

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
		default: freq_sel = {26{1'bx}};
	endcase
    end

    //instantiate frequency divider

    freq_divider tone_gen(  .inclk(clk), 
                            .outclk(div_out), 
                            .rst(rst), 
                            .div(freq_sel[25:0]));

    //set on off switch
    assign out = ~switches[0] ? 1'b0 : div_out;
endmodule


