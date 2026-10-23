----------------------------------------------------------------------------------
-- CSE 450 Final Project : Mini 8-bit Accumulator CPU
-- Student ID : 22201086   |   Set 6 : LDI, ADD, SUB, JZ, SHL
-- Module     : pc_reg
-- 4-bit program counter, rising-edge clocked, synchronous active-high RESET.
--   RESET = 1            -> PC <- 0
--   RESET = 0, JUMP = 1  -> PC <- JUMP_ADDR   (JZ taken)
--   RESET = 0, JUMP = 0  -> PC <- PC + 1
-- PC + 1 is computed with the structural adder_4bit from the lab work.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_reg is
    Port ( CLK       : in  STD_LOGIC;
           RESET     : in  STD_LOGIC;
           JUMP      : in  STD_LOGIC;
           JUMP_ADDR : in  STD_LOGIC_VECTOR (3 downto 0);
           PC        : out STD_LOGIC_VECTOR (3 downto 0));
end pc_reg;

architecture Behavioral of pc_reg is

    component adder_4bit
        Port ( A    : in  STD_LOGIC_VECTOR (3 downto 0);
               B    : in  STD_LOGIC_VECTOR (3 downto 0);
               CIN  : in  STD_LOGIC;
               SUM  : out STD_LOGIC_VECTOR (3 downto 0);
               COUT : out STD_LOGIC);
    end component;

    signal pc_r    : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal pc_plus : STD_LOGIC_VECTOR (3 downto 0);

begin

    -- PC + 1
    U_INC: adder_4bit port map ( A => pc_r, B => "0001", CIN => '0',
                                 SUM => pc_plus, COUT => open );

    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                pc_r <= (others => '0');
            elsif JUMP = '1' then
                pc_r <= JUMP_ADDR;
            else
                pc_r <= pc_plus;
            end if;
        end if;
    end process;

    PC <= pc_r;

end Behavioral;
