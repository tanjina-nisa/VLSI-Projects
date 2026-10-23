----------------------------------------------------------------------------------
-- CSE 450 Final Project : Mini 8-bit Accumulator CPU
-- Student ID : 22201086   |   Set 6 : LDI, ADD, SUB, JZ, SHL
-- Module     : control_unit
-- Decodes opcode = instr(11:8) and generates:
--   ALU_SEL  : 00 = pass operand (LDI), 01 = ADD, 10 = SUB, 11 = SHL
--   ACC_LOAD : 1 -> ACC and Z are written at the rising edge
--   PC_JUMP  : 1 -> PC <- operand(3:0)  (JZ with Z = 1), else PC <- PC + 1
--
--   Opcode  Instr   ALU_SEL  ACC_LOAD  PC_JUMP
--   0001    LDI       00        1         0
--   0010    ADD       01        1         0
--   0011    SUB       10        1         0
--   1000    SHL       11        1         0
--   1100    JZ        --        0         Z
--   others  NOP       --        0         0
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port ( OPCODE   : in  STD_LOGIC_VECTOR (3 downto 0);
           Z        : in  STD_LOGIC;
           ALU_SEL  : out STD_LOGIC_VECTOR (1 downto 0);
           ACC_LOAD : out STD_LOGIC;
           PC_JUMP  : out STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is
begin

    process (OPCODE, Z)
    begin
        -- default = NOP
        ALU_SEL  <= "00";
        ACC_LOAD <= '0';
        PC_JUMP  <= '0';

        case OPCODE is
            when "0001" =>              -- LDI imm
                ALU_SEL  <= "00";
                ACC_LOAD <= '1';
            when "0010" =>              -- ADD imm
                ALU_SEL  <= "01";
                ACC_LOAD <= '1';
            when "0011" =>              -- SUB imm
                ALU_SEL  <= "10";
                ACC_LOAD <= '1';
            when "1000" =>              -- SHL
                ALU_SEL  <= "11";
                ACC_LOAD <= '1';
            when "1100" =>              -- JZ addr
                PC_JUMP  <= Z;
            when others =>              -- NOP (0000 and every opcode not in Set 6)
                null;
        end case;
    end process;

end Behavioral;
