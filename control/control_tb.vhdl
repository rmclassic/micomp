library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behav of test is
  component control
    port(
      opcode : in std_logic_vector(5 downto 0);
      RegDst : out std_logic;
      MemToReg : out std_logic;
      Reg_Write : out std_logic;
      MemRead : out std_logic;
      MemWrite : out std_logic;
      AluOp : out std_logic_vector(1 downto 0)
    );
  end component;
    signal opcode :std_logic_vector(5 downto 0);
    signal RegDst : std_logic;
    signal MemToReg : std_logic;
    signal Reg_Write : std_logic;
    signal MemRead : std_logic;
    signal MemWrite : std_logic;
    signal AluOp : std_logic_vector(1 downto 0);
begin
  control_0: control port map(opcode, RegDst, MemToReg , Reg_Write, MemRead, MemWrite, AluOp);
  process
    type pattern_type is record
    opcode : std_logic_vector(5 downto 0);
    RegDst :  std_logic;
    MemToReg :  std_logic;
    Reg_Write :  std_logic;
    MemRead :  std_logic;
    MemWrite :  std_logic;
    AluOp :  std_logic_vector(1 downto 0);
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    (("000010", '0', '0', '1', '1', '0', "00"),
    ("000001", '1', '1', '1', '0', '0', "10"));

    begin
      for i in patterns'range loop

        opcode <= patterns(i).opcode;
        RegDst <= patterns(i).RegDst;
        MemToReg <= patterns(i).MemToReg;
        Reg_Write <= patterns(i).Reg_Write;
        MemRead <= patterns(i).MemRead;
        MemWrite <= patterns(i).MemWrite;
        AluOp <= patterns(i).AluOp;

        wait for 1 ns;

        assert AluOp = patterns(i).AluOp
          report "Result Doesn't match" severity error;
        end loop;

        assert false report "end of test" severity note;
        wait;
  end process;

end behav;
