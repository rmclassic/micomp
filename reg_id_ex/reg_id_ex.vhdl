library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_id_ex is
    port
        (
         clk         : in std_logic;
         pc          : in std_logic_vector(31 downto 0);
         pc_out      : out std_logic_vector(31 downto 0);
         zd          : in std_logic_vector(31 downto 0);
         zd_out      : out std_logic_vector(31 downto 0);
         zt          : in std_logic_vector(31 downto 0);
         zt_out      : out std_logic_vector(31 downto 0);
         read_data_1 : in std_logic_vector(31 downto 0);
         read_data_1_out : out  std_logic_vector(31 downto 0);
         read_data_2 : in std_logic_vector(31 downto 0);
         read_data_2_out : out std_logic_vector(31 downto 0);
         aluop       : in std_logic_vector(3 downto 0);
         aluop_out   : out std_logic_vector(3 downto 0);
         regdst      : in std_logic;
         regdst_out  : out std_logic;
         memwrite    : in std_logic;
         memwrite_out: out std_logic;
         memread     : in std_logic;
         memread_out : out std_logic;
         memtoreg    : in std_logic;
         memtoreg_out: out std_logic;
         write_reg   : in std_logic
        );

end reg_id_ex;

architecture behav of reg_id_ex is
    -- Register file
    signal pc_reg : std_logic_vector(31 downto 0);
    signal zd_reg: std_logic_vector(31 downto 0);
    signal zt_reg: std_logic_vector(31 downto 0);
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
          pc_out <= pc_reg;
          zd_out <= zd_reg;
          zt_out <= zt_reg;
          aluop_out <= aluop_reg;
          regdst_out <= regdst_reg;
          memwrite_out <= memwrite_reg;
          memread_out <= memread_reg;
          memtoreg_out <= memtoreg_reg;

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
