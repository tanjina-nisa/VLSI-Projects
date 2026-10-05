library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_unit is
    Port (
        A : in  STD_LOGIC_VECTOR(3 downto 0);
        B : in  STD_LOGIC_VECTOR(3 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end and_unit;

architecture Behavioral of and_unit is
begin
    Y(0) <= A(0) and B(0);
    Y(1) <= A(1) and B(1);
    Y(2) <= A(2) and B(2);
    Y(3) <= A(3) and B(3);
end Behavioral;