library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hazard_detection_unit is

    port 
        (reg_zt_id : in std_logic_vector(4 downto 0)
        ;reg_zs_id : in std_logic_vector(4 downto 0)
	;reg_zt_ex : in std_logic_vector(4 downto 0)
	;memread_ex : in std_logic

	;pc_write : out std_logic
	;ifid_write : out std_logic
	;stall_sel : out std_logic
	);
end hazard_detection_unit;

architecture Behavioral of hazard_detection_unit is


begin

    process(memread_ex, reg_zt_id, reg_zs_id, reg_zt_ex)
    begin
	if (memread_ex = '1') -- Lc is only instruction that read from memory
	then 
	    if (reg_zt_ex = reg_zs_id or reg_zt_ex = reg_zt_id) -- pipeline shouid not be stall just because it is Lc
		then                                            -- ther must also be a data dependency
	        pc_write <= '0';
	        ifid_write <= '0';
	        stall_sel <= '1';
	    else
	        pc_write <= '1';
	        ifid_write <= '1';
	        stall_sel <= '0';
	    end if;
	end if;
    end process;

end Behavioral;




