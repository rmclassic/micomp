library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity adder is
  port (
  N1: in std_logic_vector(15 downto 0);
  N2: in std_logic_vector(15 downto 0);
  Result: out std_logic_vector(15 downto 0)
  );
end adder;

architecture behav of adder is
  begin
    Result <= std_logic_vector(unsigned(N1) +  unsigned(N2));
end behav;
