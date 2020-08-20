library IEEE;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
    component forwarding_unit
      port
          (
          reg_zs_ex : in  std_logic_vector(4 downto 0);
          reg_zt_ex : in  std_logic_vector(4 downto 0);
          reg_zd_mem  : in  std_logic_vector(4 downto 0);
          reg_zd_wb   : in  std_logic_vector(4 downto 0);
          regwrite_mem       : in  std_logic;
          regwrite_wb        : in  std_logic;
          forwardA : out std_logic_vector(1 downto 0);
          forwardB : out std_logic_vector(1 downto 0)
          );

    end component;

    signal reg_zs_ex : std_logic_vector(4 downto 0);
    signal reg_zt_ex : std_logic_vector(4 downto 0);
    signal reg_zd_mem  : std_logic_vector(4 downto 0);
    signal reg_zd_wb   : std_logic_vector(4 downto 0);
    signal regwrite_mem       : std_logic;
    signal regwrite_wb        : std_logic;
    signal forwardA : std_logic_vector(1 downto 0);
    signal forwardB : std_logic_vector(1 downto 0);

begin
  fw_0: forwarding_unit port map (reg_zs_ex, reg_zt_ex, reg_zd_mem, reg_zd_wb, regwrite_mem, regwrite_wb, forwardA, forwardB);

process
  type pattern_type is record
  reg_zs_ex : std_logic_vector(4 downto 0);
  reg_zt_ex : std_logic_vector(4 downto 0);
  reg_zd_mem  : std_logic_vector(4 downto 0);
  reg_zd_wb   : std_logic_vector(4 downto 0);
  regwrite_mem       : std_logic;
  regwrite_wb        : std_logic;
  forwardA : std_logic_vector(1 downto 0);
  forwardB : std_logic_vector(1 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
  (("00001", "00010", "00001", "00001", '1', '1', "01", "00"),
  ("00001", "00010", "00011", "00001", '1', '1', "10", "00"),
  ("00011", "00001", "00011", "00001", '1', '1', "01", "10"));

begin
  for i in patterns'range loop

    reg_zs_ex <= patterns(i).reg_zs_ex;
    reg_zt_ex <= patterns(i).reg_zt_ex;
    reg_zd_mem <= patterns(i).reg_zd_mem;
    reg_zd_wb <= patterns(i).reg_zd_wb;
    regwrite_mem <= patterns(i).regwrite_mem;
    regwrite_wb <= patterns(i).regwrite_wb;
    forwardA <= patterns(i).forwardA;
    forwardB <= patterns(i).forwardB;

    wait for 3 ns;

    assert forwardA = patterns(i).forwardA
      report "Result Doesn't match" severity error;

      assert forwardB = patterns(i).forwardB
        report "Result Doesn't match" severity error;
    end loop;

    assert false report "end of test" severity note;
    wait;
  end process;
end behav;
