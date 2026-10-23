library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- DIFF = A - B  =  A + (NOT B) + 1   (uses the existing adder_8bit)
-- BORROW = 1 when A < B
entity sub_8bit is
    Port ( A      : in  STD_LOGIC_VECTOR (7 downto 0);
           B      : in  STD_LOGIC_VECTOR (7 downto 0);
           DIFF   : out STD_LOGIC_VECTOR (7 downto 0);
           BORROW : out STD_LOGIC);
end sub_8bit;

architecture Structural of sub_8bit is

    component adder_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               CIN  : in  STD_LOGIC;
               SUM  : out STD_LOGIC_VECTOR (7 downto 0);
               COUT : out STD_LOGIC);
    end component;

    signal nb   : STD_LOGIC_VECTOR (7 downto 0);
    signal cout : STD_LOGIC;

begin

    nb <= not B;                                   -- invert B

    U1: adder_8bit port map ( A => A, B => nb, CIN => '1', SUM => DIFF, COUT => cout );

    BORROW <= not cout;                            -- borrow = NOT carry

end Structural;