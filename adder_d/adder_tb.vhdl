library IEEE;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
    component adder
      port (N1, N2: in std_logic_vector(15 downto 0); Result: out std_logic_vector(15 downto 0));
    end component;

    for adder_0: adder use entity work.Adder;
    signal N1, N2: std_logic_vector(15 downto 0);
    signal Res: std_logic_vector(15 downto 0);

begin
  adder_0: adder port map (N1 => N1, N2 => N2, Result => Res);

process
  type pattern_type is record
  N1, N2: std_logic_vector(15 downto 0);
  Res: std_logic_vector(15 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array :=
(("0000000000000110", "0000000000001110", "0000000000010100"),
("0000000000000010", "0000000000000010", "0000000000000100"));

begin
  for i in patterns'range loop

    N1 <= patterns(i).N1;
    N2 <= patterns(i).N2;
    Res <= patterns(i).Res;

    wait for 1 ns;

    assert Res = patterns(i).Res
      report "Result Doesn't match" severity error;
    end loop;

    assert false report "end of test" severity note;
    wait;
  end process;
end behav;
