library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_ex_mem is
    port
        (
         clk            : in std_logic;
         newpc          : in std_logic_vector(31 downto 0);
         newpc_out      : out std_logic_vector(31 downto 0);
         alures         : in std_logic_vector(31 downto 0);
         alures_out     : out std_logic_vector(31 downto 0);
         aluzero        : in std_logic;
         aluzero_out    : inout std_logic;
         read_data_2    : in std_logic_vector(31 downto 0);
         read_data_2_out: out std_logic_vector(31 downto 0);
         dst_reg        : in std_logic_vector(4 downto 0);
         dst_reg_out    : out std_logic_vector(4 downto 0);
         memwrite    : in std_logic;
         memwrite_out: out std_logic;
         memread     : in std_logic;
         memread_out : out std_logic;
         memtoreg    : in std_logic;
         memtoreg_out: out std_logic;
         regwrite    : in std_logic;
         regwrite_out: out std_logic;
         write_reg      : in std_logic
        );

end reg_ex_mem;

architecture behav of reg_ex_mem is
    -- Register file
    signal newpc_reg : std_logic_vector(31 downto 0);
    signal alures_reg: std_logic_vector(31 downto 0);
    signal aluzero_reg: std_logic;
    signal read_data_2_reg: std_logic_vector(31 downto 0);
    signal memwrite_reg    :  std_logic;
    signal memread_reg     :  std_logic;
    signal memtoreg_reg    :  std_logic;
    signal dst_reg_reg:         std_logic_vector(4 downto 0);
    signal regwrite_reg : std_logic;


begin

--------------------------------------------------
------------   READ REGISTERS -------------------
--------------------------------------------------
    process (clk, newpc, alures, aluzero, dst_reg, read_data_2)
    begin
        if clk = '1' then
          report "Reading DATA" severity note;
          newpc_out <= newpc_reg;
          alures_out <= alures_reg;
          aluzero_out <= aluzero_reg;
          dst_reg_out <= dst_reg_reg;
          regwrite_out <= regwrite_reg;
          memwrite_out <= memwrite_reg;
          memread_out <= memread_reg;
          memtoreg_out <= memtoreg_reg;
          read_data_2_out <= read_data_2_reg;
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
          regwrite_reg <= regwrite;
          memwrite_reg <= memwrite;
          memread_reg <= memread;
          memtoreg_reg <= memtoreg;

          read_data_2_reg <= read_data_2;
        end if;
      end if;
    end process;
end behav;
