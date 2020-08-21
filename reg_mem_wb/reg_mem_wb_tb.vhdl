library IEEE;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
    component reg_mem_wb
      port
          (
           clk            : in std_logic;
           mem_read_data    : in std_logic_vector(31 downto 0);
           mem_read_data_out: out std_logic_vector(31 downto 0);
           alures         : in std_logic_vector(31 downto 0);
           alures_out     : out std_logic_vector(31 downto 0);
           dst_reg        : in std_logic_vector(4 downto 0);
           dst_reg_out    : out std_logic_vector(4 downto 0);
           memtoreg    : in std_logic;
           memtoreg_out: out std_logic;
           regwrite    : in std_logic;
           regwrite_out: out std_logic;
           write_reg      : in std_logic
          );
    end component;
    for reg: reg_mem_wb use entity work.reg_mem_wb;

    signal clk            :  std_logic;
    signal mem_read_data    :  std_logic_vector(31 downto 0);
    signal mem_read_data_out:   std_logic_vector(31 downto 0);
    signal alures         :  std_logic_vector(31 downto 0);
    signal alures_out     :   std_logic_vector(31 downto 0);
    signal dst_reg        :  std_logic_vector(4 downto 0);
    signal dst_reg_out    :   std_logic_vector(4 downto 0);
    signal memtoreg    :  std_logic;
    signal memtoreg_out:   std_logic;
    signal regwrite    :  std_logic;
    signal regwrite_out:   std_logic;
    signal write_reg      :  std_logic;

begin
  reg: reg_mem_wb port map (clk, mem_read_data, mem_read_data_out, alures, alures_out, dst_reg, dst_reg_out, memtoreg, memtoreg_out, regwrite, regwrite_out, write_reg);

process
  type pattern_type is record
    clk            :   std_logic;
    mem_read_data    :   std_logic_vector(31 downto 0);
    mem_read_data_out:    std_logic_vector(31 downto 0);
    alures         :   std_logic_vector(31 downto 0);
    alures_out     :    std_logic_vector(31 downto 0);
    dst_reg        :   std_logic_vector(4 downto 0);
    dst_reg_out    :    std_logic_vector(4 downto 0);
    memtoreg    :   std_logic;
    memtoreg_out:    std_logic;
    regwrite     :   std_logic;
    regwrite_out :    std_logic;
    write_reg      :   std_logic;
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(('0', "00000000000000001101000000000000", "00000000000000001101000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00010", "00010",'0', '0', '0', '0', '0'),
('1', "00000000000000001101000000000000", "00000000000000001101000000000000", "00000000000000001101000000000000", "00000000000000000000000000000000", "00010", "00010",'0', '0', '0', '0', '1'),
('0', "00000000000000001101000000001000", "00000000000000001101000000001000", "00000000000000001101000000001000", "00000000000000000000000000000000", "00010", "00010",'0', '0', '0', '0', '0'),
('1', "00000000000000001101000000000000", "00000000000000001101000000000000", "00000000000000001101000000001000", "00000000000000001101000000000000", "00010", "00010",'0', '0', '0', '0', '0'));

begin
  for i in patterns'range loop

    clk              <= patterns(i).clk;
    mem_read_data  <= patterns(i).mem_read_data;
    mem_read_data_out<= patterns(i).mem_read_data_out;
    alures        <= patterns(i).alures;
    alures_out     <= patterns(i).alures_out;
    dst_reg      <= patterns(i).dst_reg;
    dst_reg_out   <= patterns(i).dst_reg_out;
    memtoreg      <= patterns(i).memtoreg;
    memtoreg_out   <= patterns(i).memtoreg_out;
    regwrite      <= patterns(i).regwrite;
    regwrite_out   <= patterns(i).regwrite_out;
    write_reg       <= patterns(i).write_reg;

    wait for 3 ns;

    assert false report "end of test" severity note;

  end loop;
  wait;
  end process;
end behav;
