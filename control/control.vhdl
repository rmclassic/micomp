library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is

  port(
    opcode : in std_logic_vector(5 downto 0);
  	RegDst : out std_logic;
  	MemToReg : out std_logic;
  	Reg_Write : out std_logic;
  	MemRead : out std_logic;
  	MemWrite : out std_logic;
  	AluOp : out std_logic_vector(1 downto 0)
	);

end control;


architecture Behavioral of control is

begin
process(opcode)
    begin
    case opcode is
	when "000000" => RegDst <= '0'; --NOP
			 MemToReg <= '0';
			 Reg_Write <= '0';
			 MemRead <= '0';
			 MemWrite <= '0';
			 AluOp <= "10";

	when "000001" => RegDst <= '1'; -- Rtype
			 MemToReg <= '0';
			 Reg_Write <= '1';
			 MemRead <= '0';
			 MemWrite <= '0';
			 AluOp <= "10";

	when "000010" => RegDst <= '0'; -- Lc
			 MemToReg <= '1';
			 Reg_Write <= '1';
			 MemRead <= '1';
			 MemWrite <= '0';
			 AluOp <= "00";

	when "000011" => RegDst <= '-'; -- Sc
			 MemToReg <= '-';
			 Reg_Write <= '0';
			 MemRead <= '0';
			 MemWrite <= '1';
			 AluOp <= "00";

    	when others =>   RegDst <= '0';
			 MemToReg <= '0';
			 Reg_Write <= '0';
			 MemRead <= '0';
			 MemWrite <= '0';
			 AluOp <= "10";

    end case;
end process;

end Behavioral;
