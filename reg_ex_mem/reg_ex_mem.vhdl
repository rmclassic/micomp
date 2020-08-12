library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_id_ex is
    port
        (
         clk            : in std_logic;
         newpc          : inout std_logic_vector(31 downto 0);
         alures         : inout std_logic_vector(31 downto 0);
         aluzero        : inout std_logic;
         read_data_2    : inout std_logic_vector(31 downto 0);
         dst_reg        : inout std_logic_vector(31 downto 0);
         write_reg      : in std_logic
        );

end reg_id_ex;

architecture behav of reg_id_ex is
    -- Register file
    signal newpc_reg : std_logic_vector(31 downto 0);
    signal alures_reg: std_logic_vector(31 downto 0);
    signal aluzero_reg: std_logic;
    signal read_data_2_reg: std_logic_vector(31 downto 0);
    signal dst_reg_reg:         std_logic_vector(31 downto 0);

begin

--------------------------------------------------
------------   READ REGISTERS -------------------
--------------------------------------------------
    process (clk, newpc, alures, aluzero, dst_reg, read_data_2)
    begin
        if clk = '1' then
          report "Reading DATA" severity note;
          newpc <= newpc_reg;
          alures <= alures_reg;
          aluzero <= aluzero_reg;
          dst_reg <= dst_reg_reg;
          read_data_2 <= read_data_2_reg;
        end if;
    end process;


--------------------------------------------------
------------   WRITE REGISTERS -------------------
--------------------------------------------------
    process (clk, write_reg, newpc, alures,aluzero,dst_reg,read_data_2)
    begin
      if clk = '1' then
        if write_reg = '1' then
          report "Writing DATA" severity note;

          newpc_reg <= newpc;
          alures_reg <= alures;
          aluzero_reg <= aluzero;
          dst_reg_reg <= dst_reg;
          read_data_2 <= read_data_2_reg;
        end if;
      end if;
    end process;
end behav;
