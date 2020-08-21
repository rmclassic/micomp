library ieee;
use ieee.std_logic_1164.all;

entity mux3_1_32b is
  port (
    i0: in std_logic_vector(31 downto 0);
    i1: in std_logic_vector(31 downto 0);
    i2: in std_logic_vector(31 downto 0);
    s: in std_logic_vector(1 downto 0);
    o: out std_logic_vector(31 downto 0)
  );
end entity mux3_1_32b;

architecture behav of mux3_1_32b is
  begin

    b_mux: process(i0,i1,i2,s)
    begin
    case s is
      when "00" => o <= i0;
      when "01" => o <= i1;
      when "10" => o <= i2;
      when others => o <= i0;
    end case;
  end process b_mux;
end architecture behav;
