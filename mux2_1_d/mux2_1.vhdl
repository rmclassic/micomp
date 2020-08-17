library ieee;
use ieee.std_logic_1164.all;

entity mux2_1_16b is
  port (
    i0: in std_logic_vector(15 downto 0);
    i1: in std_logic_vector(15 downto 0);
    s: in std_logic;
    o: out std_logic_vector(15 downto 0)
  );
end entity mux2_1_16b;

library ieee;
use ieee.std_logic_1164.all;
entity mux2_1_32b is
  port (
    i0: in std_logic_vector(31 downto 0);
    i1: in std_logic_vector(31 downto 0);
    s: in std_logic;
    o: out std_logic_vector(31 downto 0)
  );
end entity mux2_1_32b;


library ieee;
use ieee.std_logic_1164.all;
entity mux2_1_8b is
  port (
    i0: in std_logic_vector(7 downto 0);
    i1: in std_logic_vector(7 downto 0);
    s: in std_logic;
    o: out std_logic_vector(7 downto 0)
  );
end entity mux2_1_8b;

library ieee;
use ieee.std_logic_1164.all;
entity mux2_1_4b is
  port (
    i0: in std_logic_vector(3 downto 0);
    i1: in std_logic_vector(3 downto 0);
    s: in std_logic;
    o: out std_logic_vector(3 downto 0)
  );
end entity mux2_1_4b;

library ieee;
use ieee.std_logic_1164.all;
entity mux2_1_5b is
  port (
    i0: in std_logic_vector(4 downto 0);
    i1: in std_logic_vector(4 downto 0);
    s: in std_logic;
    o: out std_logic_vector(4 downto 0)
  );
end entity mux2_1_5b;

architecture behav of mux2_1_16b is
  begin

    b_mux: process(i0,i1,s)
    begin
    case s is
      when '0' => o <= i0;
      when '1' => o <= i1;
      when others => o <= i0;
    end case;
  end process b_mux;
end architecture behav;

architecture behav of mux2_1_8b is
  begin

    b_mux: process(i0,i1,s)
    begin
    case s is
      when '0' => o <= i0;
      when '1' => o <= i1;
      when others => o <= i0;

    end case;
  end process b_mux;
end architecture behav;

architecture behav of mux2_1_4b is
  begin

    b_mux: process(i0,i1,s)
    begin
    case s is
      when '0' => o <= i0;
      when '1' => o <= i1;
      when others => o <= i0;

    end case;
  end process b_mux;
end architecture behav;

architecture behav of mux2_1_5b is
  begin

    b_mux: process(i0,i1,s)
    begin
    case s is
      when '0' => o <= i0;
      when '1' => o <= i1;
      when others => o <= i0;

    end case;
  end process b_mux;
end architecture behav;

architecture behav of mux2_1_32b is
  begin

    b_mux: process(i0,i1,s)
    begin
    case s is
      when '0' => o <= i0;
      when '1' => o <= i1;
      when others => o <= i0;

    end case;
  end process b_mux;
end architecture behav;
