# Tune_manipulator_using_VHDL
## Overview
The system was implemented on a Xilinx FPGA using the Vivado Design Suite and the Zybo board. In this program, we use the Audio Codec in the Zybo board to generate 3 unique 8 note tunes. Each of the notes in each tune can be manipulated using the button on the Zybo board to create a new tune. We use a PLL (Phase Locked Loop) to create a 12.288MHz clock using the on board 125MHz clock for the Audio Codec. Each note is sample at a 48KHz frequency. 
