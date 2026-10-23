----------------------------------------------------------------------------------
-- CSE 450 Final Project : Mini 8-bit Accumulator CPU
-- Student ID : 22201086   |   Set 6 : LDI, ADD, SUB, JZ, SHL
-- Module     : alu_cpu
-- 8-bit combinational ALU working on ACC and the 8-bit operand.
--   ALU_SEL = 00 : RESULT = OPERAND             (LDI)
--   ALU_SEL = 01 : RESULT = ACC + OPERAND       (ADD, carry discarded)
--   ALU_SEL = 10 : RESULT = ACC - OPERAND       (SUB, modulo 256)
--   ALU_SEL = 11 : RESULT = ACC(6:0) & '0'      (SHL, 0 enters LSB)
-- ADD and SUB reuse the structural adder_8bit and sub_8bit from the lab work.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_cpu is
    Port ( ACC     : in  STD_LOGIC_VECTOR (7 downto 0);
           OPERAND : in  STD_LOGIC_VECTOR (7 downto 0);
           ALU_SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           RESULT  : out STD_LOGIC_VECTOR (7 downto 0));
end alu_cpu;

architecture Structural of alu_cpu is

    component adder_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               CIN  : in  STD_LOGIC;
               SUM  : out STD_LOGIC_VECTOR (7 downto 0);
               COUT : out STD_LOGIC);
    end component;

    component sub_8bit
        Port ( A      : in  STD_LOGIC_VECTOR (7 downto 0);
               B      : in  STD_LOGIC_VECTOR (7 downto 0);
               DIFF   : out STD_LOGIC_VECTOR (7 downto 0);
               BORROW : out STD_LOGIC);
    end component;

    signal add_r, sub_r, shl_r : STD_LOGIC_VECTOR (7 downto 0);

begin

    -- ACC + OPERAND (carry-out not used)
    U_ADD: adder_8bit port map ( A => ACC, B => OPERAND, CIN => '0',
                                 SUM => add_r, COUT => open );

    -- ACC - OPERAND (borrow not used, result is modulo 256)
    U_SUB: sub_8bit   port map ( A => ACC, B => OPERAND,
                                 DIFF => sub_r, BORROW => open );

    -- shift left by 1, 0 enters LSB
    shl_r <= ACC(6 downto 0) & '0';

    -- 4:1 output multiplexer
    with ALU_SEL select
        RESULT <= OPERAND when "00",
                  add_r   when "01",
                  sub_r   when "10",
                  shl_r   when others;

end Structural;
