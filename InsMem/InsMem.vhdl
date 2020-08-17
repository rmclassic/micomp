library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity insmem is
  port (
    clk     : in  std_logic;
    address : in  std_logic_vector(31 downto 0);
    dataout : out std_logic_vector(31 downto 0)
  );
end entity insmem;

architecture RTL of insmem is

   type ram_type is array (0 to (2**address'length)-1) of std_logic_vector(31 downto 0);
   signal ram : ram_type;
   signal read_address : std_logic_vector(31 downto 0);

begin

  process(clk) is

  begin
    if rising_edge(clk) then
      read_address <= address;
      dataout <= ram(to_integer(unsigned(read_address)));

    end if;
  end process;


end architecture RTL;
