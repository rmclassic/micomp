library IEEE;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
    component mux
      port (i0, i1, i2, i3, i4, i5, i6, i7: in std_logic_vector(31 downto 0); s: in std_logic_vector(2 downto 0); o: out std_logic_vector(31 downto 0));
    end component;

    for mux_0: mux use entity work.mux8_1_32b;
    signal i0, i1, i2, i3, i4, i5, i6, i7: std_logic_vector(31 downto 0);
    signal s: std_logic_vector(2 downto 0);
    signal o: std_logic_vector(31 downto 0);

begin
  mux_0: mux port map (i0 => i0, i1 => i1,i2 => i2,i3 => i3,i4 => i4,i5 => i5,i6 => i6,i7 => i7, s => s, o => o);

process
  type pattern_type is record
  i0, i1, i2, i3, i4, i5, i6, i7: std_logic_vector(31 downto 0);
  s: std_logic_vector(2 downto 0);
  o: std_logic_vector(31 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("00000000000000000000000000000000", "00000000000000000000000000000001", "00000000000000000000000000000010", "00000000000000000000000000000011", "00000000000000000000000000000100", "00000000000000000000000000000101" ,"00000000000000000000000000000110", "00000000000000000000000000000111","101" ,"00000000000000000000000000000101"),
("00000000000000000000000000000000", "00000000000000000000000000000001", "00000000000000000000000000000010","00000000000000000000000000000011", "00000000000000000000000000000100", "00000000000000000000000000000101" ,"00000000000000000000000000000110", "00000000000000000000000000000111","000" ,"00000000000000000000000000000000"));

begin
  for i in patterns'range loop

    i0 <= patterns(i).i0;
    i1 <= patterns(i).i1;
    i2 <= patterns(i).i2;
    i3 <= patterns(i).i3;
    i4 <= patterns(i).i4;
    i5 <= patterns(i).i5;
    i6 <= patterns(i).i6;
    i7 <= patterns(i).i7;
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
