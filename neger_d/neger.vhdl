library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity neger_16b is
  port (
    i: in std_logic_vector(15 downto 0);
    o: out std_logic_vector(15 downto 0)
  );

end neger_16b;

architecture behav of neger_16b is
  begin
  process (i)
  begin
    if (i(15) = '1')then
      o <= not std_logic_vector(unsigned(i) - 1);
    elsif (i(15) = '0') then
      o <= std_logic_vector(unsigned(not i) + 1);
  end if;
end process;
end architecture behav;
