----------------------------------------------------------------------------------
-- CSE 450 Final Project : Mini 8-bit Accumulator CPU
-- Student ID : 22201086   |   Set 6 : LDI, ADD, SUB, JZ, SHL
-- Module     : cpu_tb  (testbench)
-- * 10 ns clock (rising edges at 5, 15, 25, ... ns)
-- * RESET = 1 for exactly one rising edge (cycle 0)
-- * runs the Appendix B Set 6 program and checks ACC, Z and next PC
--   after every rising edge against the expected table.
-- Waveform: add CLK, RESET, PC, Q (ACC), Z.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpu_tb is
end cpu_tb;

architecture Behavioral of cpu_tb is

    component cpu_top
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               Q     : out STD_LOGIC_VECTOR (7 downto 0);
               Z     : out STD_LOGIC;
               PC    : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '1';
    signal Q     : STD_LOGIC_VECTOR (7 downto 0);
    signal Z     : STD_LOGIC;
    signal PC    : STD_LOGIC_VECTOR (3 downto 0);

    signal sim_done : boolean := false;

    constant CLK_PERIOD : time := 10 ns;

    -- expected values after each rising edge (Appendix B, Set 6)
    --   cycle :    0     1     2     3     4     5     6     7     8
    type byte_arr is array (0 to 8) of STD_LOGIC_VECTOR (7 downto 0);
    type bit_arr  is array (0 to 8) of STD_LOGIC;
    type pc_arr   is array (0 to 8) of integer;

    constant EXP_ACC : byte_arr := (x"00", x"02", x"01", x"01", x"00",
                                    x"00", x"21", x"42", x"43");
    constant EXP_Z   : bit_arr  := ('1', '0', '0', '0', '1',
                                    '1', '0', '0', '0');
    constant EXP_PC  : pc_arr   := (0, 1, 2, 3, 4, 7, 8, 9, 10);

begin

    UUT: cpu_top port map ( CLK => CLK, RESET => RESET, Q => Q, Z => Z, PC => PC );

    -- clock generator (stops when the test is finished)
    clk_proc: process
    begin
        while not sim_done loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    stim_proc: process
        variable errors : integer := 0;
    begin
        -- cycle 0 : RESET = 1 for one rising edge
        RESET <= '1';
        wait until rising_edge(CLK);
        wait for 2 ns;
        RESET <= '0';

        for i in 0 to 8 loop
            if i > 0 then
                wait until rising_edge(CLK);   -- execute instruction at ROM[PC]
                wait for 2 ns;                 -- let outputs settle
            end if;

            if (Q /= EXP_ACC(i)) or (Z /= EXP_Z(i)) or
               (to_integer(unsigned(PC)) /= EXP_PC(i)) then
                errors := errors + 1;
                report "FAIL cycle " & integer'image(i) &
                       " : ACC=" & integer'image(to_integer(unsigned(Q))) &
                       " exp=" & integer'image(to_integer(unsigned(EXP_ACC(i)))) &
                       "  Z=" & std_logic'image(Z) &
                       "  PC=" & integer'image(to_integer(unsigned(PC))) &
                       " exp=" & integer'image(EXP_PC(i))
                       severity error;
            else
                report "cycle " & integer'image(i) & " OK : ACC=" &
                       integer'image(to_integer(unsigned(Q))) &
                       "  Z=" & std_logic'image(Z) &
                       "  next PC=" & integer'image(to_integer(unsigned(PC)))
                       severity note;
            end if;
        end loop;

        if errors = 0 then
            report "CPU TEST PASSED : Set 6 program executed correctly (final ACC = 0x43)"
                severity note;
        else
            report "CPU TEST FAILED : " & integer'image(errors) & " error(s)"
                severity error;
        end if;

        sim_done <= true;   -- stop the clock, final PC stays 10
        wait;
    end process;

end Behavioral;
