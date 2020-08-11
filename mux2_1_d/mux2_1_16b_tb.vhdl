library IEEE;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
    component mux
      port (i0, i1: in std_logic_vector(15 downto 0); s: in bit; o: out std_logic_vector(15 downto 0));
    end component;

    for mux_0: mux use entity work.mux2_1_16b;
    signal i0, i1: std_logic_vector(15 downto 0);
    signal s: bit;
    signal o: std_logic_vector(15 downto 0);

begin
  mux_0: mux port map (i0 => i0, i1 => i1, s => s, o => o);

process
  type pattern_type is record
  i0, i1: std_logic_vector(15 downto 0);
  s: bit;
  o: std_logic_vector(15 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("0000000000000110", "0000000000001110",'0' ,"0000000000000110"),
("0000000000000110", "0000000000001110",'1' ,"0000000000001110"));

begin
  for i in patterns'range loop

    i0 <= patterns(i).i0;
    i1 <= patterns(i).i1;
    s <= patterns(i).s;
    o <= patterns(i).o;

    wait for 3 ns;

    assert o = patterns(i).o
      report "Result Doesn't match" severity error;
    end loop;

    assert false report "end of test" severity note;
    wait;
  end process;
end behav;
