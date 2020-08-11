library IEEE;
use IEEE.std_logic_1164.all;

entity test is
end test;

architecture behav of test is
  component multip
    port (Nibble1, Nibble2 : in std_logic_vector(3 downto 0); Result : out std_logic_vector(7 downto 0));
  end component;

  for mult: multip use entity work.Multiplier;
  signal N1, N2: std_logic_vector(3 downto 0);
  signal Res: std_logic_vector(7 downto 0);

begin
  mult: multip port map (Nibble1 => N1, Nibble2 => N2, Result => Res);

process
  type pattern_type is record
    N1, N2: std_logic_vector(3 downto 0);
    Res: std_logic_vector(7 downto 0);
  end record;

  type pattern_array is array (natural range <>) of pattern_type;
  constant patterns : pattern_array :=
  (("0010", "0011", "00000110"),
  ("0100", "0001", "00000100"));

  begin
  for i in patterns'range loop

    N1 <= patterns(i).N1;
    N2 <= patterns(i).N2;
    Res <= patterns(i).Res;

    wait for 1 ns;
    assert Res = patterns(i).Res
      report "Result doesn't match" severity error;
  end loop;

  assert false report "end of test" severity note;
  wait;
end process;
end behav;
