----------------------------------------------------------------------------------
-- CSE 450 Final Project : Mini 8-bit Accumulator CPU
-- Student ID : 22201086   |   Set 6 : LDI, ADD, SUB, JZ, SHL
-- Module     : cpu_top  (TOP LEVEL)
-- Connects PC -> Program ROM -> Control Unit / ALU -> ACC, Z.
-- Single-cycle: fetch, decode and execute in one clock, written at rising edge.
-- Ports: CLK, RESET, Q[7:0] (= ACC), Z, PC[3:0]
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
    Port ( CLK   : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q     : out STD_LOGIC_VECTOR (7 downto 0);
           Z     : out STD_LOGIC;
           PC    : out STD_LOGIC_VECTOR (3 downto 0));
end cpu_top;

architecture Structural of cpu_top is

    component pc_reg
        Port ( CLK       : in  STD_LOGIC;
               RESET     : in  STD_LOGIC;
               JUMP      : in  STD_LOGIC;
               JUMP_ADDR : in  STD_LOGIC_VECTOR (3 downto 0);
               PC        : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component program_rom
        Port ( ADDR  : in  STD_LOGIC_VECTOR (3 downto 0);
               INSTR : out STD_LOGIC_VECTOR (11 downto 0));
    end component;

    component control_unit
        Port ( OPCODE   : in  STD_LOGIC_VECTOR (3 downto 0);
               Z        : in  STD_LOGIC;
               ALU_SEL  : out STD_LOGIC_VECTOR (1 downto 0);
               ACC_LOAD : out STD_LOGIC;
               PC_JUMP  : out STD_LOGIC);
    end component;

    component alu_cpu
        Port ( ACC     : in  STD_LOGIC_VECTOR (7 downto 0);
               OPERAND : in  STD_LOGIC_VECTOR (7 downto 0);
               ALU_SEL : in  STD_LOGIC_VECTOR (1 downto 0);
               RESULT  : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component acc_z_reg
        Port ( CLK   : in  STD_LOGIC;
               RESET : in  STD_LOGIC;
               LOAD  : in  STD_LOGIC;
               D     : in  STD_LOGIC_VECTOR (7 downto 0);
               ACC   : out STD_LOGIC_VECTOR (7 downto 0);
               Z     : out STD_LOGIC);
    end component;

    signal pc_s       : STD_LOGIC_VECTOR (3 downto 0);
    signal instr_s    : STD_LOGIC_VECTOR (11 downto 0);
    signal opcode_s   : STD_LOGIC_VECTOR (3 downto 0);
    signal operand_s  : STD_LOGIC_VECTOR (7 downto 0);
    signal alu_sel_s  : STD_LOGIC_VECTOR (1 downto 0);
    signal acc_load_s : STD_LOGIC;
    signal pc_jump_s  : STD_LOGIC;
    signal alu_res_s  : STD_LOGIC_VECTOR (7 downto 0);
    signal acc_s      : STD_LOGIC_VECTOR (7 downto 0);
    signal z_s        : STD_LOGIC;

begin

    -- split the instruction
    opcode_s  <= instr_s(11 downto 8);
    operand_s <= instr_s(7 downto 0);

    U_PC:  pc_reg       port map ( CLK => CLK, RESET => RESET,
                                   JUMP => pc_jump_s, JUMP_ADDR => operand_s(3 downto 0),
                                   PC => pc_s );

    U_ROM: program_rom  port map ( ADDR => pc_s, INSTR => instr_s );

    U_CU:  control_unit port map ( OPCODE => opcode_s, Z => z_s,
                                   ALU_SEL => alu_sel_s, ACC_LOAD => acc_load_s,
                                   PC_JUMP => pc_jump_s );

    U_ALU: alu_cpu      port map ( ACC => acc_s, OPERAND => operand_s,
                                   ALU_SEL => alu_sel_s, RESULT => alu_res_s );

    U_ACC: acc_z_reg    port map ( CLK => CLK, RESET => RESET, LOAD => acc_load_s,
                                   D => alu_res_s, ACC => acc_s, Z => z_s );

    -- outputs
    Q  <= acc_s;
    Z  <= z_s;
    PC <= pc_s;

end Structural;
