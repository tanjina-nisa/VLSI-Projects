CSE 450 Final Project - Mini 8-bit Accumulator CPU
Student ID : 22201086  |  Set 6 : LDI, ADD, SUB, JZ, SHL
Xilinx ISE 14.7, Spartan6 xc6slx4 (same settings as the lab project)

HOW TO OPEN
1. Extract the zip, e.g. to /home/ise/VLSI/CPU_22201086
2. ISE -> File -> Open Project -> CPU_22201086.xise
3. Implementation view : top = cpu_top  (right-click -> Set as Top Module if needed)
4. Simulation view     : select cpu_tb -> ISim Simulator -> Simulate Behavioral Model
5. In ISim: run for 120 ns (or Run All). The console shows "cycle N OK"
   for each cycle and finally:
   "CPU TEST PASSED : Set 6 program executed correctly (final ACC = 0x43)"
6. For the waveform screenshot, add CLK, RESET, PC, Q, Z
   (right-click Q -> Radix -> Hexadecimal, PC -> Unsigned Decimal).

FILES
Reused from the lab project (Computer_22201086 zip):
  nand_gate, not_gate, and_gate, or_gate, xor_gate,
  half_adder, full_adder, adder_4bit, adder_8bit, sub_8bit
New for the CPU:
  program_rom.vhd   16x12 ROM with the Set 6 program
  pc_reg.vhd        4-bit PC (PC+1 uses adder_4bit, JZ loads operand(3:0))
  control_unit.vhd  opcode decoder -> ALU_SEL, ACC_LOAD, PC_JUMP
  alu_cpu.vhd       LDI / ADD (adder_8bit) / SUB (sub_8bit) / SHL
  acc_z_reg.vhd     ACC + Z flag (reset: ACC=0x00, Z=1)
  cpu_top.vhd       top level: CLK, RESET, Q[7:0], Z, PC[3:0]
  cpu_tb.vhd        testbench with self-checking against Appendix B

EXPECTED RESULT (Appendix B, Set 6)
Cycle  PC  Instruction        ACC   Z  Next PC
  0    -   RESET              0x00  1   0
  1    0   LDI 0x02           0x02  0   1
  2    1   SUB 0x01           0x01  0   2
  3    2   JZ 0x07 (not tkn)  0x01  0   3
  4    3   SUB 0x01           0x00  1   4
  5    4   JZ 0x07 (taken)    0x00  1   7
  6    7   LDI 0x21           0x21  0   8
  7    8   SHL                0x42  0   9
  8    9   ADD 0x01           0x43  0   10
