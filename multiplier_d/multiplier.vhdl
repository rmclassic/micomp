library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier is
   port
   (
      Nibble1, Nibble2: in std_logic_vector(15 downto 0);

      Result: out std_logic_vector(15 downto 0)
   );
end entity Multiplier;

architecture Behavioral of Multiplier is
  signal rs: std_logic_vector(31 downto 0);
begin

   rs <= std_logic_vector(unsigned(Nibble1) * unsigned(Nibble2));
   Result <= rs(15 downto 0);
end architecture Behavioral;
