library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is

  port(
  opcode : in std_logic_vector(8 downto 0);
	RegDst : out std_logic;
	MemToReg : out std_logic;
	Reg_Write : out std_logic;
	MemRead : out std_logic;
	MemWrite : out std_logic;
	AluOp : out std_logic_vector(2 downto 0)l
	);

end control;


architecture Behavioral of control is

begin
process(opcode)
    begin
    case opcode is
	when "00000000" =>
       RegDst <= '0'; -- NOP
			 MemToReg <= '0';
			 Reg_Write <= '0';
			 MemRead <= '0';
			 MemWrite <= '0';
			 AluOp <= "000";

	when "00000001" =>
       RegDst <= '0'; -- Addc
			 MemToReg <= '1';
			 Reg_Write <= '1';
			 MemRead <= '0';
			 MemWrite <= '0';
			 AluOp <= "010";

	when "00000010" =>
       RegDst <= '0'; -- Subc
			 MemToReg <= '1';
			 Reg_Write <= '1';
			 MemRead <= '0';
			 MemWrite <= '0';
			 AluOp <= "011";


  when "00000011" =>
      RegDst <= '0'; -- Mulc
     	MemToReg <= '1';
     	Reg_Write <= '1';
     	MemRead <= '0';
     	MemWrite <= '0';
     	AluOp <= "100";


  when "00000100" =>
      RegDst <= '0'; -- Divc
      MemToReg <= '1';
      Reg_Write <= '1';
      MemRead <= '0';
      MemWrite <= '0';
      AluOp <= "101";

  when "00000100" =>
      RegDst <= '0'; -- Negc
      MemToReg <= '1';
      Reg_Write <= '1';
      MemRead <= '0';
      MemWrite <= '0';
      AluOp <= "110";

  when "00000100" =>
      RegDst <= '1'; -- Lc
      MemToReg <= '0';
      Reg_Write <= '1';
      MemRead <= '1';
      MemWrite <= '0';
      AluOp <= "000";

  when "00000101" =>
      RegDst <= '-'; -- Sc
      MemToReg <= '0';
      Reg_Write <= '0';
      MemRead <= '1';
      MemWrite <= '0';
      AluOp <= "000";

    end case;
end process;
end Behavioral;
