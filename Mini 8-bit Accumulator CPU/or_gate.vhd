library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_gate is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end or_gate;

architecture Structural of or_gate is

    component nand_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal not_a, not_b : STD_LOGIC;

begin

    -- NAND 1: NOT A
    U1: nand_gate
        port map (
            A => A,
            B => A,
            Y => not_a
        );

    -- NAND 2: NOT B
    U2: nand_gate
        port map (
            A => B,
            B => B,
            Y => not_b
        );

    -- NAND 3: OR
    U3: nand_gate
        port map (
            A => not_a,
            B => not_b,
            Y => Y
        );

end Structural;