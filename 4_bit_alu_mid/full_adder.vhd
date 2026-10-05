library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        CIN  : in  STD_LOGIC;
        SUM  : out STD_LOGIC;
        COUT : out STD_LOGIC
    );
end full_adder;

architecture Behavioral of full_adder is
begin

    SUM <= A xor B xor CIN;

    COUT <= (A and B) or
            (A and CIN) or
            (B and CIN);

end Behavioral;