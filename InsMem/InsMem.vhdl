library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity insmem is
  port (
    clk     : in  std_logic;
    address : in  std_logic_vector(31 downto 0);
    dataout : out std_logic_vector(31 downto 0);
    datain  : in std_logic_vector(31 downto 0);
    writeins: in std_logic
  );
end entity insmem;

architecture RTL of insmem is

   type ram_type is array (0 to 65535) of std_logic_vector(31 downto 0);
   signal ram : ram_type;
   signal read_address : std_logic_vector(31 downto 0);

begin

  process(clk)

  begin
    if rising_edge(clk) then
      dataout <= ram(to_integer(unsigned(address)));
      report "read data" severity note;
      if writeins = '1' then
        ram(to_integer(unsigned(address))) <= datain;
        report "wrote data" severity note;
      end if;
    end if;
  end process;


end architecture RTL;
