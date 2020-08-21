library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behav of test is
  component reg_id_ex
    port
        (
         clk         : in std_logic;
         pc          : in std_logic_vector(31 downto 0);
         pc_out      : out std_logic_vector(31 downto 0);
         zd          : in std_logic_vector(4 downto 0);
         zd_out      : out std_logic_vector(4 downto 0);
         zt          : in std_logic_vector(4 downto 0);
         zt_out      : out std_logic_vector(4 downto 0);
         zs          : in std_logic_vector(4 downto 0);
         zs_out      : out std_logic_vector(4 downto 0);
         read_data_1 : in std_logic_vector(31 downto 0);
         read_data_1_out : out  std_logic_vector(31 downto 0);
         read_data_2 : in std_logic_vector(31 downto 0);
         read_data_2_out : out std_logic_vector(31 downto 0);
         aluop       : in std_logic_vector(1 downto 0);
         aluop_out   : out std_logic_vector(1 downto 0);
         func        : in std_logic_vector(5 downto 0);
         func_out    : out std_logic_vector(5 downto 0);
         regdst      : in std_logic;
         regdst_out  : out std_logic;
         memwrite    : in std_logic;
         memwrite_out: out std_logic;
         memread     : in std_logic;
         memread_out : out std_logic;
         memtoreg    : in std_logic;
         memtoreg_out: out std_logic;
         regwrite    : in std_logic;
         regwrite_out: out std_logic;
         write_reg   : in std_logic
        );
  end component;

  signal clk          :std_logic;
  signal pc           :std_logic_vector(31 downto 0);
  signal pc_out      : std_logic_vector(31 downto 0);
  signal zd           :std_logic_vector(4 downto 0);
  signal zd_out      : std_logic_vector(4 downto 0);
  signal zt          :std_logic_vector(4 downto 0);
  signal zt_out      : std_logic_vector(4 downto 0);
  zs          : std_logic_vector(4 downto 0);
  zs_out      : std_logic_vector(4 downto 0);
  signal read_data_1  :std_logic_vector(31 downto 0);
  signal read_data_1_out :  std_logic_vector(31 downto 0);
  signal read_data_2 :std_logic_vector(31 downto 0);
  signal read_data_2_out : std_logic_vector(31 downto 0);
  signal aluop        :std_logic_vector(1 downto 0);
  signal aluop_out   : std_logic_vector(1 downto 0);
  signal func        :std_logic_vector(5 downto 0);
  signal func_out    : std_logic_vector(5 downto 0);
  signal regdst      :std_logic;
  signal regdst_out  : std_logic;
  signal memwrite    :std_logic;
  signal memwrite_out: std_logic;
  signal memread      :std_logic;
  signal memread_out : std_logic;
  signal memtoreg    :std_logic;
  signal memtoreg_out: std_logic;
  signal regwrite     :std_logic;
  signal regwrite_out: std_logic;
  signal write_reg   : std_logic;
begin
  r_0: reg_id_ex port map(clk, pc, pc_out, zd, zd_out, zt, zt_out, zs, zs_out, read_data_1, read_data_1_out, read_data_2, read_data_2_out, aluop, aluop_out, func, func_out, regdst, regdst_out, memwrite, memwrite_out, memread, memread_out, memtoreg, memtoreg_out, regwrite, regwrite_out, write_reg);
  process
    type pattern_type is record
     clk          :std_logic;
     pc           :std_logic_vector(31 downto 0);
     pc_out      : std_logic_vector(31 downto 0);
     zd           :std_logic_vector(4 downto 0);
     zd_out      : std_logic_vector(4 downto 0);
     zt          :std_logic_vector(4 downto 0);
     zt_out      : std_logic_vector(4 downto 0);
     zs          : std_logic_vector(4 downto 0);
     zs_out      : std_logic_vector(4 downto 0);
     read_data_1  :std_logic_vector(31 downto 0);
     read_data_1_out :  std_logic_vector(31 downto 0);
     read_data_2 :std_logic_vector(31 downto 0);
     read_data_2_out : std_logic_vector(31 downto 0);
     aluop        :std_logic_vector(1 downto 0);
     aluop_out   : std_logic_vector(1 downto 0);
     func        :std_logic_vector(5 downto 0);
     func_out    : std_logic_vector(5 downto 0);
     regdst      :std_logic;
     regdst_out  : std_logic;
     memwrite    :std_logic;
     memwrite_out: std_logic;
     memread      :std_logic;
     memread_out : std_logic;
     memtoreg    :std_logic;
     memtoreg_out: std_logic;
     regwrite     :std_logic;
     regwrite_out: std_logic;
     write_reg   : std_logic;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    (('0', "00000000000000000000000000001100", "00000000000000000000000000001100", "00100", "00100", "00100", "00100","00100", "00100", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000","01", "01", "010010", "010010", '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0'),
    ('1', "00000000000000000000000000001100", "00000000000000000000000000001100", "00100", "00100", "00100", "00100","00100", "00100", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000","01", "01", "010010", "010010", '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'),
    ('0', "00000000000000000000000000001100", "00000000000000000000000000001100", "00100", "00100", "00100", "00100","00100", "00100", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000","01", "01", "010010", "010010", '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'),
    ('1', "00000000000000000000000000001100", "00000000000000000000000000001100", "00100", "00100", "00100", "00100","00100", "00100", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000","01", "01", "010010", "010010", '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0'));

    begin
      for i in patterns'range loop

        clk <= patterns(i).clk;

        pc          <= patterns(i).pc;
        pc_out      <= patterns(i).pc_out;
        zd         <= patterns(i).zd;
        zd_out     <= patterns(i).zd_out;
        zt        <= patterns(i).zt;
        zt_out     <= patterns(i).zt_out;
        zs        <= patterns(i).zs;
        zs_out   <= patterns(i).zs_out;
        read_data_1 <= patterns(i).read_data_1;
        read_data_1_out  <= patterns(i).read_data_1_out;
        read_data_2 <= patterns(i).read_data_2;
        read_data_2_out <= patterns(i).read_data_2_out;
        aluop      <= patterns(i).aluop;
        aluop_out  <= patterns(i).aluop_out;
        func      <= patterns(i).func;
        func_out   <= patterns(i).func_out;
        regdst     <= patterns(i).regdst;
        regdst_out  <= patterns(i).regdst_out;
        memwrite   <= patterns(i).memwrite;
        memwrite_out<= patterns(i).memwrite_out;
        memread     <= patterns(i).memread;
        memread_out <= patterns(i).memread_out;
        memtoreg   <= patterns(i).memtoreg;
        memtoreg_out<= patterns(i).memtoreg_out;
        regwrite    <= patterns(i).regwrite;
        regwrite_out<= patterns(i).regwrite_out;
        write_reg   <= patterns(i).write_reg;


        wait for 10 ns;
        end loop;

        assert false report "end of test" severity note;
        wait;
  end process;

end behav;
