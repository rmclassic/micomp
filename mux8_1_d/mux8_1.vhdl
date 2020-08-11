library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity mux8_1_32b is
  port (
    i0: in std_logic_vector(31 downto 0);
    i1: in std_logic_vector(31 downto 0);
    i2: in std_logic_vector(31 downto 0);
    i3: in std_logic_vector(31 downto 0);
    i4: in std_logic_vector(31 downto 0);
    i5: in std_logic_vector(31 downto 0);
    i6: in std_logic_vector(31 downto 0);
    i7: in std_logic_vector(31 downto 0);
    s: in std_logic_vector(2 downto 0);
    o: out std_logic_vector(31 downto 0)
  );
end entity mux8_1_32b;

architecture behav of mux8_1_32b is
  begin

    b_mux: process(i0, i1, i2, i3, i4, i5, i6, i7,s)
    begin
    case s is
      when "000" => o <= i0;
      when "001" => o <= i1;
      when "010" => o <= i2;
      when "011" => o <= i3;
      when "100" => o <= i4;
      when "101" => o <= i5;
      when "110" => o <= i6;
      when "111" => o <= i7;
      when others => o <= i0;
    end case;
  end process b_mux;
end architecture behav;
