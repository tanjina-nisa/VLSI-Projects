library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_adder_4bit is
-- Testbench entity remains empty
end tb_adder_4bit;

architecture Behavioral of tb_adder_4bit is

    -- Component Declaration for the Device Under Test (DUT)
    component adder_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR (3 downto 0);
            B    : in  STD_LOGIC_VECTOR (3 downto 0);
            CIN  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR (3 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    -- Signal Declarations to connect to DUT inputs and outputs
    signal tb_A    : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal tb_B    : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal tb_CIN  : STD_LOGIC := '0';
    signal tb_SUM  : STD_LOGIC_VECTOR (3 downto 0);
    signal tb_COUT : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: adder_4bit
        port map (
            A    => tb_A,
            B    => tb_B,
            CIN  => tb_CIN,
            SUM  => tb_SUM,
            COUT => tb_COUT
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Hold reset state for 20 ns
        wait for 20 ns;

        -- Test Case 1: 0 + 0 + 0 = 0 (COUT = 0)
        tb_A   <= "0000";
        tb_B   <= "0000";
        tb_CIN <= '0';
        wait for 10 ns;

        -- Test Case 2: 5 + 3 + 0 = 8 (COUT = 0)
        tb_A   <= "0101"; -- 5
        tb_B   <= "0011"; -- 3
        tb_CIN <= '0';
        wait for 10 ns;

        -- Test Case 3: 5 + 3 + 1 = 9 (COUT = 0)
        tb_A   <= "0101"; -- 5
        tb_B   <= "0011"; -- 3
        tb_CIN <= '1';
        wait for 10 ns;

        -- Test Case 4: 10 + 7 + 0 = 17 -> SUM = 1 (0001), COUT = 1
        tb_A   <= "1010"; -- 10
        tb_B   <= "0111"; -- 7
        tb_CIN <= '0';
        wait for 10 ns;

        -- Test Case 5: 15 + 15 + 1 = 31 -> SUM = 15 (1111), COUT = 1
        tb_A   <= "1111"; -- 15
        tb_B   <= "1111"; -- 15
        tb_CIN <= '1';
        wait for 10 ns;

        -- Test Case 6: 0 + 15 + 1 = 16 -> SUM = 0 (0000), COUT = 1
        tb_A   <= "0000";
        tb_B   <= "1111";
        tb_CIN <= '1';
        wait for 10 ns;

        -- Stop simulation
        wait;
    end process;

end Behavioral;