library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4to1 is
    Port (
        D0  : in  STD_LOGIC_VECTOR(3 downto 0);
        D1  : in  STD_LOGIC_VECTOR(3 downto 0);
        D2  : in  STD_LOGIC_VECTOR(3 downto 0);
        D3  : in  STD_LOGIC_VECTOR(3 downto 0);
        SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        Y   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end mux_4to1;

architecture Behavioral of mux_4to1 is
begin

    Y <= D0 when SEL = "00" else
         D1 when SEL = "01" else
         D2 when SEL = "10" else
         D3;

end Behavioral;