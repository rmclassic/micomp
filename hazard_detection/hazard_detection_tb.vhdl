library IEEE;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
    component hazard_detection_unit
      port(
        reg_zt_id : in std_logic_vector(4 downto 0);
        reg_zs_id : in std_logic_vector(4 downto 0);
        reg_zt_ex : in std_logic_vector(4 downto 0);
        memread_ex : in std_logic;
        pc_write : out std_logic;
        ifid_write : out std_logic;
        stall_sel : out std_logic
      );
    end component;

    signal reg_zt_id : std_logic_vector(4 downto 0);
    signal reg_zs_id : std_logic_vector(4 downto 0);
    signal reg_zt_ex : std_logic_vector(4 downto 0);
    signal memread_ex : std_logic;
    signal pc_write :  std_logic;
    signal ifid_write :  std_logic;
    signal stall_sel :  std_logic;

begin
  hdu_0: hazard_detection_unit port map (reg_zt_id, reg_zs_id, reg_zt_ex, memread_ex, pc_write, ifid_write, stall_sel);

process
  type pattern_type is record
    reg_zt_id : std_logic_vector(4 downto 0);
    reg_zs_id : std_logic_vector(4 downto 0);
    reg_zt_ex : std_logic_vector(4 downto 0);
    memread_ex : std_logic;
    pc_write :  std_logic;
    ifid_write :  std_logic;
    stall_sel :  std_logic;
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("00010", "00001","00010" , '1', '0', '0', '1'),
("00010", "00001","00001" , '1', '0', '0', '1'),
("00010", "00001","00001" , '0', '1', '1', '0'),
("00010", "00001","00011" , '1', '1', '1', '0'));

begin
  for i in patterns'range loop

    reg_zt_id <= patterns(i).reg_zt_id;
    reg_zs_id <= patterns(i).reg_zs_id;
    reg_zt_ex <= patterns(i).reg_zt_ex;
    memread_ex <= patterns(i).memread_ex;
    pc_write <= patterns(i).pc_write;
    ifid_write <= patterns(i).ifid_write;
    stall_sel <= patterns(i).stall_sel;

    wait for 3 ns;

    assert stall_sel = patterns(i).stall_sel
      report "Result Doesn't match" severity error;
    end loop;

    assert false report "end of test" severity note;
    wait;
  end process;
end behav;
