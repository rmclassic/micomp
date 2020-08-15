library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_im_id is
    port
        (
         clk         : in std_logic;
         pc          : in std_logic_vector(31 downto 0);
         pc_out      : out std_logic_vector(31 downto 0);
         ins         : in std_logic_vector(31 downto 0);
         ins_out     : out std_logic_vector(31 downto 0);
         write_reg   : in std_logic
        );

end reg_im_id;

architecture behav of reg_im_id is
    -- Register file
    signal pc_reg : std_logic_vector(31 downto 0);
    signal instruction: std_logic_vector(31 downto 0);

begin

--------------------------------------------------
------------   READ REGISTERS -------------------
--------------------------------------------------
    process (clk, write_reg, pc_in, ins)
    begin
        if clk = '1' then
          report "Reading DATA" severity note;
          pc_out <= pc_reg;
          ins_out <= instruction;
        end if;
    end process;


--------------------------------------------------
------------   WRITE REGISTERS -------------------
--------------------------------------------------
    process (clk, write_reg, pc, ins)
    begin
      if clk = '1' then
        if write_reg = '1' then
          report "Writing DATA" severity note;

          pc_reg <= pc;
          instruction <= ins;
        end if;
      end if;
    end process;
end behav;
