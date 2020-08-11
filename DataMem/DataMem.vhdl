library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity datamem is
  port (
    clk          : in  std_logic;
    address      : in  std_logic_vector(31 downto 0);
    datain       : in  std_logic_vector(31 downto 0);
    write_enable : in  std_logic;
    dataout      : out std_logic_vector(31 downto 0)
  );
end entity datamem;

architecture RTL of datamem is

   type ram_type is array (0 to (2**address'length)-1) of std_logic_vector(31 downto 0);
   signal ram : ram_type;

begin

  process(clk) is

  begin
    if rising_edge(clk) then
      if (write_enable = '1') then
        ram(to_integer(unsigned(address))) <= datain;
      else
        dataout <= ram(to_integer(unsigned(address)));
      end if;
    end if;
  end process;

end architecture RTL;
