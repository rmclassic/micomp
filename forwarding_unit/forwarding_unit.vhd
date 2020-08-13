library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwarding_unit is

    port
        ( reg_zs_ex : in  std_logic_vector(4 downto 0)
        ; reg_zt_ex : in  std_logic_vector(4 downto 0)
        ; reg_zd_mem  : in  std_logic_vector(4 downto 0)
        ; reg_zd_wb   : in  std_logic_vector(4 downto 0)
        ; regwrite_mem       : in  std_logic
        ; regwrite_wb        : in  std_logic

        ; forwardA : out std_logic_vector(1 downto 0)
        ; forwardB : out std_logic_vector(1 downto 0)
        );

end forwarding_unit;

architecture Behavioral of forwarding_unit is

signal a : std_logic;
signal b : std_logic;
signal hazard_mem : std_logic;
signal c : std_logic;
signal d : std_logic;
signal hazard_wb : std_logic;
signal not_hazard_mem : std_logic;
signal b1 : std_logic;
signal d1 : std_logic;
signal hazard_mem1 : std_logic;
signal hazard_wb1 : std_logic;
signal not_hazard_mem1 : std_logic;

begin

-------------------------------------------------------------------------------------------------------------------------------
---------------- forward frome state Mem ----------------------------------------
a <= reg_zd_mem(4) or reg_zd_mem(3) or reg_zd_mem(2) or reg_zd_mem(1) or reg_zd_mem(0); -- if (ex/mem.zd != 0) then a = 1
process(reg_zs_ex,reg_zd_mem)
begin
    if reg_zd_mem = reg_zs_ex
    then
       b <= '1';
    end if;
end process;
hazard_mem <= a and b and regwrite_mem;
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
------------------- forward from state Wb -----------------------
c <= reg_zd_wb(4) or reg_zd_wb(3) or reg_zd_wb(2) or reg_zd_wb(1) or reg_zd_wb(0); -- if ( mem/wb.regwrite == 1 ) then c = 1
process(reg_zs_ex,reg_zd_wb)
begin
    if reg_zd_wb = reg_zs_ex
    then
       d <= '1';
    end if;
end process;
hazard_wb <= c and d and regwrite_wb;
--------------------------------------------------------------------------------------------------------------------------------


-- if ( ex/mem.regwrite == 1 ) and
--    ( ex/mem.zd == id/ex.zs ) and
--    ( ex/mem.zd != 0 ) 
--    forwardA = 01 ( forward from mem state )

-- if ( mem/wb.regwrite == 1 ) and
--    ( mem/wb.zd == id/ex.zs ) and
--    ( mem/wb.zd != 0 ) 
--    forwardA = 10 ( forward from wb state )

-------------- forward from mux A --------------------
forwardA(0) <= hazard_mem;
not_hazard_mem <= not hazard_mem;
forwardA(1) <= not_hazard_mem and hazard_wb; --if both of Mem and Wb have data dependency => forward from M state 

-----------------------------------------------------------------------------------------------------------------
---------------- forward from state Mem -------------------------
process(reg_zt_ex,reg_zd_mem)
begin
    if reg_zd_mem = reg_zt_ex
    then
       b1 <= '1';
    end if;
end process;
hazard_mem1 <= a and b1 and regwrite_mem;
------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------
---------------- forward from state Wb --------------------------
process(reg_zt_ex,reg_zd_wb)
begin
    if reg_zd_wb = reg_zt_ex
    then
       d1 <= '1';
    end if;
end process;
hazard_wb1 <= c and d1 and regwrite_wb;
------------------------------------------------------------------------------------------------------------------

-- if ( ex/mem.regwrite == 1 ) and
--    ( ex/mem.zd == id/ex.zt ) and
--    ( ex/mem.zd != 0 ) 
--    forwardB  = 01 ( forward from mem state )

-- if ( mem/wb.regwrite == 1 ) and
--    ( mem/wb.zd == id/ex.zt ) and
--    ( mem/wb.zd != 0 ) 
--    forwardB = 10 ( forward from wb state 

--------------- forward from mux B --------------
forwardB(0) <= hazard_mem1;
not_hazard_mem1 <= not hazard_mem1; --if both of Mem and Wb have data dependency => forward from M state
forwardB(1) <= not_hazard_mem1 and hazard_wb1;

 
end Behavioral;
