library IEEE;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
    component neger
      port (i: in std_logic_vector(15 downto 0); o: out std_logic_vector(15 downto 0));
    end component;

    for neg_0: neger use entity work.neger_16b;
    signal i: std_logic_vector(15 downto 0);
    signal o: std_logic_vector(15 downto 0);

begin
  neg_0: neger port map (i => i, o => o);

process
  type pattern_type is record
  i: std_logic_vector(15 downto 0);
  o: std_logic_vector(15 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("0000000000000001", "1111111111111111"),
("0000000000000010", "1111111111111110"));

begin
  for a in patterns'range loop

    i <= patterns(a).i;
    o <= patterns(a).o;

    wait for 3 ns;

    assert o = patterns(a).o
      report "Result Doesn't match" severity error;
    end loop;

    assert false report "end of test" severity note;
    wait;
  end process;
end behav;
