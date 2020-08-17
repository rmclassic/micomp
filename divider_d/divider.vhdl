library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divider is
   port
   (
      Nibble1, Nibble2: in std_logic_vector(15 downto 0);

      Result: out std_logic_vector(15 downto 0)
   );
end entity divider;

architecture Behavioral of divider is
begin

   Result <= std_logic_vector(unsigned(Nibble1) / unsigned(Nibble2));

end architecture Behavioral;
