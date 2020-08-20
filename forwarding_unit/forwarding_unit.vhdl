library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwarding_unit is

    port
        (
        reg_zs_ex : in  std_logic_vector(4 downto 0);
        reg_zt_ex : in  std_logic_vector(4 downto 0);
        reg_zd_mem  : in  std_logic_vector(4 downto 0);
        reg_zd_wb   : in  std_logic_vector(4 downto 0);
        regwrite_mem       : in  std_logic;
        regwrite_wb        : in  std_logic;
        forwardA : out std_logic_vector(1 downto 0);
        forwardB : out std_logic_vector(1 downto 0)
        );

end forwarding_unit;

architecture Behavioral of forwarding_unit is

signal foundA, foundB: std_logic;

begin

  process (reg_zs_ex, reg_zt_ex, reg_zd_mem)
  begin
    foundA <= '0';
    foundB <= '0';
    if (regwrite_mem = '1') and (reg_zd_mem = reg_zs_ex) and (reg_zd_mem /= "00000") then
      report  integer'image(to_integer(unsigned(reg_zd_mem)));
      report  integer'image(to_integer(unsigned(reg_zs_ex)));
      forwardA <= "01";
      foundA <= '1';
    elsif (regwrite_wb = '1') and (reg_zd_wb = reg_zs_ex) and (reg_zd_wb /= "00000") and (foundA = '0') then
      forwardA <= "10";
    else
      forwardA <= "00";
    end if;

    if (regwrite_mem = '1') and (reg_zd_mem = reg_zt_ex) and (reg_zd_mem /= "00000") then
      forwardB <= "01";
      foundB <= '1';
    elsif (regwrite_wb = '1') and (reg_zd_wb = reg_zt_ex) and (reg_zd_wb /= "00000") and (foundB = '0') then
      forwardB <= "10";
    else
      forwardB <= "00";
    end if;
  end process;

-- if ( ex/mem.regwrite == 1 ) and
--    ( ex/mem.zd == id/ex.zs ) and
--    ( ex/mem.zd != 0 )
--    forwardA = 01 ( forward from mem state )

-- if ( mem/wb.regwrite == 1 ) and
--    ( mem/wb.zd == id/ex.zs ) and
--    ( mem/wb.zd != 0 )
--    forwardA = 10 ( forward from wb state )


end Behavioral;
