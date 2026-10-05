library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_unit is
    Port (
        A : in  STD_LOGIC_VECTOR(3 downto 0);
        B : in  STD_LOGIC_VECTOR(3 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end or_unit;

architecture Behavioral of or_unit is
begin
    Y(0) <= A(0) or B(0);
    Y(1) <= A(1) or B(1);
    Y(2) <= A(2) or B(2);
    Y(3) <= A(3) or B(3);
end Behavioral;