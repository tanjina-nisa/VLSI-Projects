library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_4bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(3 downto 0);
        B    : in  STD_LOGIC_VECTOR(3 downto 0);
        SEL  : in  STD_LOGIC_VECTOR(1 downto 0);
        Y    : out STD_LOGIC_VECTOR(3 downto 0);
        COUT : out STD_LOGIC
    );
end alu_4bit;

architecture Structural of alu_4bit is

    component and_unit
        Port (
            A : in  STD_LOGIC_VECTOR(3 downto 0);
            B : in  STD_LOGIC_VECTOR(3 downto 0);
            Y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component or_unit
        Port (
            A : in  STD_LOGIC_VECTOR(3 downto 0);
            B : in  STD_LOGIC_VECTOR(3 downto 0);
            Y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component adder_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            SUM  : out STD_LOGIC_VECTOR(3 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    component mux_4to1
        Port (
            D0  : in  STD_LOGIC_VECTOR(3 downto 0);
            D1  : in  STD_LOGIC_VECTOR(3 downto 0);
            D2  : in  STD_LOGIC_VECTOR(3 downto 0);
            D3  : in  STD_LOGIC_VECTOR(3 downto 0);
            SEL : in  STD_LOGIC_VECTOR(1 downto 0);
            Y   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal AND_OUT : STD_LOGIC_VECTOR(3 downto 0);
    signal OR_OUT  : STD_LOGIC_VECTOR(3 downto 0);
    signal ADD_OUT : STD_LOGIC_VECTOR(3 downto 0);

    signal ADD_COUT : STD_LOGIC;

    signal MUX_OUT : STD_LOGIC_VECTOR(3 downto 0);

    signal ZERO : STD_LOGIC_VECTOR(3 downto 0);

begin

    ZERO <= "0000";

    -- AND Unit
    U1 : and_unit
        port map (
            A => A,
            B => B,
            Y => AND_OUT
        );

    -- OR Unit
    U2 : or_unit
        port map (
            A => A,
            B => B,
            Y => OR_OUT
        );

    -- 4-bit Ripple Carry Adder
    U3 : adder_4bit
        port map (
            A    => A,
            B    => B,
            SUM  => ADD_OUT,
            COUT => ADD_COUT
        );

    -- 4-to-1 Multiplexer
    U4 : mux_4to1
        port map (
            D0  => AND_OUT,
            D1  => OR_OUT,
            D2  => ADD_OUT,
            D3  => ZERO,
            SEL => SEL,
            Y   => MUX_OUT
        );

    -- Final ALU output
    Y <= MUX_OUT;

    -- Carry output is only valid for ADD operation
    COUT <= ADD_COUT when SEL = "10" else '0';

end Structural;