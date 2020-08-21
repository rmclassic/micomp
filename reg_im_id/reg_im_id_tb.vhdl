library IEEE;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
    component reg_im_id
      port (
      clk: in std_logic;
      ins_in: in std_logic_vector(31 downto 0);
      pc_in: in std_logic_vector(31 downto 0);
      ins_out: out std_logic_vector(31 downto 0);
      pc_out: out std_logic_vector(31 downto 0);
      write_reg: in std_logic
      );
    end component;

    for reg: reg_im_id use entity work.reg_im_id;
    signal clk: std_logic;
    signal ins_in: std_logic_vector(31 downto 0);
    signal pc_in: std_logic_vector(31 downto 0);
    signal ins_out: std_logic_vector(31 downto 0);
    signal pc_out: std_logic_vector(31 downto 0);
    signal write_reg: std_logic;

begin
  reg: reg_im_id port map (clk => clk, ins_in => ins_in, pc_in => pc_in, ins_out => ins_out, pc_out => pc_out, write_reg => write_reg);

process
  type pattern_type is record
  clk: std_logic;
  ins_in: std_logic_vector(31 downto 0);
  pc_in: std_logic_vector(31 downto 0);
  ins_out: std_logic_vector(31 downto 0);
  pc_out: std_logic_vector(31 downto 0);
  write_reg: std_logic;
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(('0', "00000000000000001101000000000000", "00000000000000000000000011000000", "00000000000000000000000000000000", "00000000000000000000000000000000", '1'),
('1', "00000000000000001101000000000000", "00000000000000000000000011000000", "00000000000000001101000000000000", "00000000000000000000000011000000", '0'),
('0', "00000000000000001101000000001000", "00000000000000000000000011100000", "00000000000000001101000000001000", "00000000000000000000000011100000", '1'),
('1', "00000000000000001101000000000000", "00000000000000000000000011000000", "00000000000000001101000000001000", "00000000000000000000000011100000", '0'));

begin
  for a in patterns'range loop
    clk <= patterns(a).clk;
    ins_in <= patterns(a).ins_in;
    ins_out <= patterns(a).ins_out;
    pc_in <= patterns(a).pc_in;
    pc_out <= patterns(a).pc_out;
    write_reg <= patterns(a).write_reg;

    wait for 3 ns;

    assert pc_out = patterns(a).pc_out
      report "pc out Doesn't match" severity error;
    end loop;

    assert false report "end of test" severity note;
    wait;
  end process;
end behav;
