library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_mem_wb is
    port
        (
         clk            : in std_logic;
         mem_read_data    : in std_logic_vector(31 downto 0);
         mem_read_data_out: out std_logic_vector(31 downto 0);
         alures         : in std_logic_vector(31 downto 0);
         alures_out     : out std_logic_vector(31 downto 0);
         dst_reg        : in std_logic_vector(4 downto 0);
         dst_reg_out    : out std_logic_vector(4 downto 0);
         memtoreg    : in std_logic;
         memtoreg_out: out std_logic;
         regwrite    : in std_logic;
         regwrite_out: out std_logic;
         write_reg      : in std_logic
        );

end reg_mem_wb;

architecture behav of reg_mem_wb is
    -- Register file
    signal alures_reg: std_logic_vector(31 downto 0);
    signal read_data_2_reg: std_logic_vector(31 downto 0);
    signal memtoreg_reg:  std_logic;
    signal dst_reg_reg:  std_logic_vector(4 downto 0);
    signal regwrite_reg: std_logic;

begin

--------------------------------------------------
------------   READ REGISTERS -------------------
--------------------------------------------------
    process (clk, alures, dst_reg, mem_read_data)
    begin
        if clk = '1' then
          report "Reading DATA" severity note;
          alures_out <= alures_reg;
          dst_reg_out <= dst_reg_reg;
          regwrite_out <= regwrite_reg;
          memtoreg_out <= memtoreg_reg;
          mem_read_data_out <= read_data_2_reg;
        end if;
    end process;


--------------------------------------------------
------------   WRITE REGISTERS -------------------
--------------------------------------------------
    process (clk, write_reg, alures,dst_reg,mem_read_data)
    begin
      if clk = '1' then
        if write_reg = '1' then
          report "Writing DATA" severity note;

          alures_reg <= alures;
          dst_reg_reg <= dst_reg;
          regwrite_reg <= regwrite;
          memtoreg_reg <= memtoreg;

          read_data_2_reg <= mem_read_data;
        end if;
      end if;
    end process;
end behav;
