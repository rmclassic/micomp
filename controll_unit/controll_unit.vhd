library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controll_unit is

    port
	(opcode : in std_logic_vector(5 downto 0)
	;RegDst : out std_logic
	;MemToReg : out std_logic
	;Reg_Write : out std_logic
	;MwmRead : out std_logic
	;MemWrite : out std_logic
	;AluOp : out std_logic_vector(1 downto 0)
	);

end controll_unit;


architecture Behavioral of controll_unit is

begin
process(opcode)
    begin
    case opcode is
	when "000000" => RegDst <= '1'; -- Rtype
			 MemToReg <= '0';
			 Reg_Write <= '1';
			 MwmRead <= '0';
			 MemWrite <= '0';
			 AluOp <= "10";

	when "100011" => RegDst <= '0'; -- Lc 
			 MemToReg <= '1';
			 Reg_Write <= '1';
			 MwmRead <= '1';
			 MemWrite <= '0';
			 AluOp <= "00"; 

	when "101011" => RegDst <= '-'; -- Sc
			 MemToReg <= '-';
			 Reg_Write <= '0';
			 MwmRead <= '0';
			 MemWrite <= '1';
			 AluOp <= "00";

    	when others =>   RegDst <= '0'; 
			 MemToReg <= '0';
			 Reg_Write <= '0';
			 MwmRead <= '0';
			 MemWrite <= '0';
			 AluOp <= "10";

    end case;
end process;
end Behavioral;
