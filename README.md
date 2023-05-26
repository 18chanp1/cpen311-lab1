# Something about the CPEN 311 Lab 1
## SOF directory path
[Basic_Organ_Solution.sof](./rtl/Basic_Organ_Solution.sof)

./rtl/Basic_Organ_Solution.sof

## Lab status
- [x] Frequency divider complete - [freq_divider.sv](./rtl/freq_divider.sv)
- [x] Audio output switch complete [tone_selector.sv](./rtl/tone_selector.sv)
- [x] Audio pitch selector switches complete -  [tone_selector.sv](./rtl/tone_selector.sv)
- [x] Info channel shows note - complete[Basic_Organ_Solution.sv](./rtl/Basic_Organ_Solution.sv)
- [x] Switch positioning on information console - complete  [Basic_Organ_Solution.sv](./rtl/Basic_Organ_Solution.sv)
- [x] Something interesting on console - complete [Basic_Organ_Solution.sv](./rtl/Basic_Organ_Solution.sv)
- [x] LED control - complete [led_flasher.sv](./rtl/led_flasher.sv)


## Annotated simulation / signaltap screenshots
![freq_divider.png](./doc/freq_divider.png)
![led_flasher.png](./doc/led_flasher.png)
![tone_selector.png](./doc/tone_selector.png)

## Information on simulations
All simulations created by quartus simulator.

LED flasher and tone selectors have had their parameters adjusted (change from order of ~100Hz to order of ~20Mhz), because the simulation would take too long. You can see the parameters set in the .sv files to determine the actual period. This is set by a parameter called DIVIDER (or some variant), and for the tone selector, parameters called DO, RE, MI…

The frequency can be obtained by clock frequency / DIVIDER. 

### Simulation for Frequency Divider
[Waveform.vwf](./component_projects/frequency_divider/Waveform.vwf)
./component_projects/frequency_divider/Waveform.vwf

Actual output
[freq_divider_20230525180337.sim.vwf](./component_projects/frequency_divider/simulation/qsim/freq_divider_20230525180337.sim.vwf)
./component_projects/frequency_divider/simulation/qsim/freq_divider_20230525180337.sim.vwf

### Simulation for led flasher
[Waveform.vwf](./component_projects/led_flasher/Waveform.vwf)
./component_projects/led_flasher/Waveform.vwf

Actual Output
[led_flasher_20230525191546.sim.vwf](./component_projects/led_flasher/simulation/qsim/led_flasher_20230525191546.sim.vwf)
./component_projects/led_flasher/simulation/qsim/led_flasher_20230525191546.sim.vwf

### Simulation for tone selector
[Waveform.vwf](./component_projects/tone_selector/Waveform.vwf)

Actual output
[tone_selector_20230525221445.sim.vwf](./component_projects/tone_selector/simulation/qsim/tone_selector_20230525221445.sim.vwf)


### Additional information
None

## Bonus Question
We peform a fourier transformation. 

We recall the fourier series for any periodic function can be written as follows:
