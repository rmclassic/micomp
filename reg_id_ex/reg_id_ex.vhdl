library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_id_ex is
    port
        (
         clk         : in std_logic;
         pc          : inout std_logic_vector(31 downto 0);
         zd          : inout std_logic_vector(31 downto 0);
         zt          : inout std_logic_vector(31 downto 0);
         read_data_1 : inout std_logic_vector(31 downto 0);
         read_data_2 : inout std_logic_vector(31 downto 0);
         alusrc      : inout std_logic;
         aluop       : inout std_logic_vector(3 downto 0);
         regdst      : inout std_logic;
         memwrite    : inout std_logic;
         memread     : inout std_logic;
         memtoreg    : inout std_logic;
         write_reg   : in std_logic
        );

end reg_id_ex;

architecture behav of reg_id_ex is
    -- Register file
    signal pc_reg : std_logic_vector(31 downto 0);
    signal zd_reg: std_logic_vector(31 downto 0);
    signal zt_reg: std_logic_vector(31 downto 0);
    signal alusrc_reg      :  std_logic;
    signal aluop_reg       :  std_logic_vector(3 downto 0);
    signal regdst_reg      :  std_logic;
    signal memwrite_reg    :  std_logic;
    signal memread_reg     :  std_logic;
    signal memtoreg_reg    :  std_logic;
    signal read_data_1_reg: std_logic_vector(31 downto 0);
    signal read_data_2_reg: std_logic_vector(31 downto 0);

begin

--------------------------------------------------
------------   READ REGISTERS -------------------
--------------------------------------------------
    process (clk, pc, zd, zt, read_data_1, read_data_2)
    begin
        if clk = '1' then
          report "Reading DATA" severity note;
          pc <= pc_reg;
          zd <= zd_reg;
          zt <= zt_reg;
          alusrc <= alusrc_reg;
          aluop <= aluop_reg;
          regdst <= regdst_reg;
          memwrite <= memwrite_reg;
          memread <= memread_reg;
          memtoreg <= memtoreg_reg;

          read_data_1 <= read_data_1_reg;
          read_data_2 <= read_data_2_reg;
        end if;
    end process;


--------------------------------------------------
------------   WRITE REGISTERS -------------------
--------------------------------------------------
    process (clk, write_reg, pc, zd,zt,read_data_1,read_data_2)
    begin
      if clk = '1' then
        if write_reg = '1' then
          report "Writing DATA" severity note;

          pc_reg <= pc;
          zd_reg <= zd;
          zt_reg <= zt;

          alusrc_reg <= alusrc;
          aluop_reg <= aluop;
          regdst_reg <= regdst;
          memwrite_reg <= memwrite;
          memread_reg <= memread;
          memtoreg_reg <= memtoreg;

          read_data_1 <= read_data_1_reg;
          read_data_2 <= read_data_2_reg;
        end if;
      end if;
    end process;
end behav;
