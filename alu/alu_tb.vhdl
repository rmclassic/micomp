library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behav of test is
  component alu
    port (
      a: in std_logic_vector(31 downto 0);
      b: in std_logic_vector(31 downto 0);
      op: in std_logic_vector(2 downto 0);
      o: out std_logic_vector(31 downto 0)
    );
  end component;
  signal a: std_logic_vector(31 downto 0);
  signal b: std_logic_vector(31 downto 0);
  signal op: std_logic_vector(2 downto 0);
  signal o: std_logic_vector(31 downto 0);
begin
  alu_0: alu port map(a, b, op ,o);
  process
    type pattern_type is record
    a: std_logic_vector(31 downto 0);
    b: std_logic_vector(31 downto 0);
    op: std_logic_vector(2 downto 0);
    o: std_logic_vector(31 downto 0);
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    (("00000000000000110000000000000010", "00000000000001010000000000000011", "010", "00000000000010000000000000000100"),
    ("00000000000000010000000000000011", "00000000000000010000000000000001", "011", "00000000000000000000000000000010"));

    begin
      for i in patterns'range loop

        a <= patterns(i).a;
        b <= patterns(i).b;
        op <= patterns(i).op;
        o <= patterns(i).o;

        wait for 1 ns;

        assert o = patterns(i).o
          report "Result Doesn't match" severity error;
        end loop;

        assert false report "end of test" severity note;
        wait;
  end process;

end behav;
