----------------------------------------------------------------------------------
-- CSE 450 Final Project : Mini 8-bit Accumulator CPU
-- Student ID : 22201086   |   Set 6 : LDI, ADD, SUB, JZ, SHL
-- Module     : program_rom
-- 16 x 12-bit program memory, read combinationally using PC (no clock).
-- instr(11:8) = opcode, instr(7:0) = operand.  Unused locations = 0x000 (NOP).
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_rom is
    Port ( ADDR  : in  STD_LOGIC_VECTOR (3 downto 0);
           INSTR : out STD_LOGIC_VECTOR (11 downto 0));
end program_rom;

architecture Behavioral of program_rom is

    type rom_type is array (0 to 15) of STD_LOGIC_VECTOR (11 downto 0);

    -- Appendix B, Set 6 program
    constant ROM : rom_type := (
        0      => x"102",   -- LDI 0x02
        1      => x"301",   -- SUB 0x01
        2      => x"C07",   -- JZ  0x07
        3      => x"301",   -- SUB 0x01
        4      => x"C07",   -- JZ  0x07
        5      => x"2AA",   -- ADD 0xAA   (skipped by JZ)
        6      => x"2AA",   -- ADD 0xAA   (skipped by JZ)
        7      => x"121",   -- LDI 0x21
        8      => x"800",   -- SHL
        9      => x"201",   -- ADD 0x01
        others => x"000"    -- NOP
    );

begin

    INSTR <= ROM(to_integer(unsigned(ADDR)));

end Behavioral;
