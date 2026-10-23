----------------------------------------------------------------------------------
-- CSE 450 Final Project : Mini 8-bit Accumulator CPU
-- Student ID : 22201086   |   Set 6 : LDI, ADD, SUB, JZ, SHL
-- Module     : acc_z_reg
-- ACC : 8-bit accumulator (also the CPU output Q)
-- Z   : 1-bit zero flag, 1 when the value written to ACC is 0x00
-- Rising-edge clocked, synchronous active-high RESET (priority):
--   RESET = 1          -> ACC <- 0x00, Z <- 1
--   RESET = 0, LOAD=1  -> ACC <- D,    Z <- (D = 0x00)
--   RESET = 0, LOAD=0  -> ACC and Z keep their values
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_z_reg is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           LOAD  : in  STD_LOGIC;
           D     : in  STD_LOGIC_VECTOR (7 downto 0);
           ACC   : out STD_LOGIC_VECTOR (7 downto 0);
           Z     : out STD_LOGIC);
end acc_z_reg;

architecture Behavioral of acc_z_reg is

    signal acc_r : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal z_r   : STD_LOGIC := '1';

begin

    process (CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                acc_r <= (others => '0');
                z_r   <= '1';
            elsif LOAD = '1' then
                acc_r <= D;
                if D = "00000000" then
                    z_r <= '1';
                else
                    z_r <= '0';
                end if;
            end if;
        end if;
    end process;

    ACC <= acc_r;
    Z   <= z_r;

end Behavioral;
