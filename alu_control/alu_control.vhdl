library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_control is

  port(
    AluOp : in std_logic_vector(1 downto 0);
    Func : in std_logic_vector(5 downto 0);
    AluControl : out std_logic_vector(2 downto 0)
  );

end alu_control;

architecture Behavioral of alu_control is
signal inputs : std_logic_vector(7 downto 0);

begin
inputs(7 downto 6) <= AluOp;
inputs(5 downto 0) <= Func;

process(inputs)
    begin
    case inputs is
	when "00------" => AluControl <= "000";
	when "01------" => AluControl <= "011";
	when "10100000" => AluControl <= "010";
	when "10100010" => AluControl <= "011";
	when "10101010" => AluControl <= "100";
	when "10100100" => AluControl <= "101";
	when "10100101" => AluControl <= "110";
	when others => AluControl <= "010";
    end case;
end process;
end Behavioral;
