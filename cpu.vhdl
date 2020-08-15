library ieee;
use ieee.std_logic_1164.all;

entity micomp is

end micomp;


architecture RTL of micomp is
  begin
    component insmem
      port (
        clk: in std_logic;
        address: in std_logic_vector(31 downto 0);
        dataout: out std_logic_vector(31 downto 0)
      );
    end component;
    component reg_im_id
    port
        (
         clk         : in std_logic;
         pc          : in std_logic_vector(31 downto 0);
         pc_out      : out std_logic_vector(31 downto 0);
         ins         : in std_logic_vector(31 downto 0);
         ins_out     : out std_logic_vector(31 downto 0);
         write_reg   : in std_logic
        );
    end component;
    component RegisterFile
      port(
        clk: in std_logic;
        read_reg_1: in std_logic_vector(4 downto 0);
        read_reg_2: in std_logic_vector(4 downto 0);
        write_reg: in std_logic_vector(4 downto 0);
        write_data: in std_logic_vector(31 downto 0);
        write_enable: in std_logic;
        read_data_1: out std_logic_vector(31 downto 0);
        read_data_2: out std_logic_vector(31 downto 0)
      );
    end component;
    component reg_id_ex
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
    end component;
    component mux2_1_32b
      port(
        i0: in std_logic_vector(3 downto 0);
        i1: in std_logic_vector(3 downto 0);
        s: in bit;
        o: out std_logic_vector(3 downto 0)
      );
    end component;
    component alu
      port(
        a: in std_logic_vector(31 downto 0);
        b: in std_logic_vector(31 downto 0);
        op: in std_logic_vector(4 downto 0);
        o: out std_logic_vector(31 downto 0)
      );
    end component;
    component reg_ex_mem
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
         dst_reg        : in std_logic_vector(31 downto 0);
         dst_reg_out    : out std_logic_vector(31 downto 0);
         memwrite    : in std_logic;
         memwrite_out: out std_logic;
         memread     : in std_logic;
         memread_out : out std_logic;
         memtoreg    : in std_logic;
         memtoreg_out: out std_logic;
         write_reg      : in std_logic
        );
    end component;
    component datamem
      port(
        clk: in std_logic;
        address: in std_logic_vector(31 downto 0);
        datain: in std_logic_vector(31 downto 0);
        write_enable: in std_logic;
        dataout: out std_logic_vector(31 downto 0)
      );
    end component;
    component reg_mem_wb
    port
        (
         clk            : in std_logic;
         read_data_2    : in std_logic_vector(31 downto 0);
         read_data_2_out: out std_logic_vector(31 downto 0);
         alures         : in std_logic_vector(31 downto 0);
         alures_out     : out std_logic_vector(31 downto 0);
         dst_reg        : in std_logic_vector(31 downto 0);
         dst_reg_out    : out std_logic_vector(31 downto 0);
         memtoreg    : in std_logic;
         memtoreg_out: out std_logic;
         write_reg      : in std_logic
        );
    end component;
    signal clk: std_logic;
    signal newpc, reg_data_1, reg_data_2, pc_id: std_logic_vector(31 downto 0);
    begin
      -------------------------------------- IF
      adder_pc: adder port map(std_logic_vector(4), pc, newpc);
      im0: insmem port map(clk, pc, insmem_data_out);
      --------------------------------------- IF/ID
      if_id_0: reg_im_id port map(clk, newpc, ins, clk);
      ---------------------------------------  ID
      rf_0: RegisterFile port map(clk, ins(12 downto 8), ins(4 downto 0), , , ,reg_data_1, reg_data_2);
      --ADD CONTROL
      --------------------------------------- ID/EX

      reg_id_ex_0: reg_id_ex port map(clk, newpc, ins(19 downto 16) , ins(4 downto 0),reg_data_1, reg_data_2, , , , , , , , clk);
      --------------------------------------- EX
      alu_0: alu port map()

  end RTL;
