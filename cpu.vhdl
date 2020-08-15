library ieee;
use ieee.std_logic_1164.all;

entity micomp is

end micomp;


architecture RTL of micomp is
  begin
    component insmem
      port (
        clk     : in std_logic;
        address : in std_logic_vector(31 downto 0);
        dataout : out std_logic_vector(31 downto 0)
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
         regwrite    : in std_logic;
         regwrite    : out std_logic;
         write_reg   : in std_logic
        );
    end component;
    component mux2_1_8b
      port(
        i0: in std_logic_vector(3 downto 0);
        i1: in std_logic_vector(3 downto 0);
        s: in bit;
        o: out std_logic_vector(3 downto 0)
      );
    end component;
    component mux2_1_32b
      port(
        i0: in std_logic_vector(31 downto 0);
        i1: in std_logic_vector(31 downto 0);
        s: in bit;
        o: out std_logic_vector(31 downto 0)
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
         dst_reg        : in std_logic_vector(8 downto 0);
         dst_reg_out    : out std_logic_vector(8 downto 0);
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
         mem_read_data    : in std_logic_vector(31 downto 0);
         mem_read_data_out: out std_logic_vector(31 downto 0);
         alures         : in std_logic_vector(31 downto 0);
         alures_out     : out std_logic_vector(31 downto 0);
         dst_reg        : in std_logic_vector(8 downto 0);
         dst_reg_out    : out std_logic_vector(8 downto 0);
         memtoreg    : in std_logic;
         memtoreg_out: out std_logic;
         regwrite    : in std_logic;
         regwrite_out : out std_logic;
         write_reg      : in std_logic
        );
    end component;
    component control
      port(
        opcode : in std_logic_vector(8 downto 0);
        RegDst : out std_logic;
        MemToReg : out std_logic;
        Reg_Write : out std_logic;
        MemRead : out std_logic;
        MemWrite : out std_logic;
        AluOp : out std_logic_vector(2 downto 0)l
      );
    end component;
    signal clk: std_logic;
    signal pc: std_logic_vector(31 downto 0);
    signal pc_if, pc_id, pc_ex, pc_mem, ins_if, ins_id, reg_data_1, reg_data_2, zd_ex, zt_ex, reg_data_1_ex, reg_data_2_ex, alu_res_ex, alu_res_mem, alu_res_wb, datamem_data_mem, datamem_data_wb: std_logic_vector(31 downto 0);
    signal aluop_ex, aluop_id: std_logic_vector(2 downto 0);
    signal regdst_id, memtoreg_id, regwrite_id, memread_id, memwrite_id: std_logic;
    signal destreg_ex: std_logic_vector(7 downto 0);
    signal regdst_ex, memtoreg_ex, regwrite_ex, memread_ex, memwrite_ex: std_logic;
    signal regdst_mem, memtoreg_mem, regwrite_mem, memread_mem, memwrite_mem: std_logic;
    signal destreg_wb, destreg_wb, regwrite_wb: std_logic;
    begin
      -------------------------------------- IF
      adder_pc: adder port map(std_logic_vector(4), pc, pc_if);
      im0: insmem port map(clk, pc, insmem_data_out);
      --------------------------------------- IF/ID
      if_id_0: reg_im_id port map(clk, pc_if, pc_id, ins_if, ins_id, clk);
      ---------------------------------------  ID
      rf_0: RegisterFile port map(clk, ins_id(12 downto 8), ins_id(4 downto 0), destreg_wb, reg_write_data_wb, regwrite_wb,reg_data_1, reg_data_2);
      control_0: control port map(ins_id(31 downto 24), regdst_id, memtoreg_id, regwrite_id, memread_id, memwrite_id, aluop_id);
      --------------------------------------- ID/EX

      reg_id_ex_0: reg_id_ex port map(clk, pc_id, pc_ex, ins_id(19 downto 16), zd_ex, ins_id(4 downto 0), zt_ex, reg_data_1, reg_data_1_ex, reg_data_2, reg_data_2_ex, aluop_id, aluop_ex, regdst_id, regdst_ex, memwrite_id, memwrite_ex, memread_id, memread_ex, memtoreg_id, memtoreg_ex, regwrite_id, regwrite_ex, clk);
      --------------------------------------- EX
      alu_0: alu port map(reg_data_1_ex, reg_data_2_ex, aluop_ex, alu_res_ex);
      mux2_1_0: mux2_1_8b port map(zd_ex, zt_ex, regdst_ex, destreg_ex);
      --------------------------------------- EX/MEM
      reg_ex_mem_0: reg_ex_mem port map(clk, pc_ex, pc_mem, alu_res_ex, alu_res_mem, '0', '0', reg_data_2_ex, reg_data_2_mem, destreg_ex, destreg_mem, memwrite_ex, memwrite_mem, memread_ex,memread_mem, memtoreg_ex, memtoreg_mem, regwrite_ex, regwrite_mem, clk);
      --------------------------------------- MEM
      datamem_0: datamem port map(clk, alu_res_ex, reg_data_2_mem, alu_res_mem, clk, datamem_data_mem);
      --------------------------------------- MEM/WB
      reg_mem_wb: reg_mem_wb port map(clk, datamem_data_mem, datamem_data_wb, alu_res_mem, alu_res_wb, destreg_mem, destreg_wb, memtoreg_mem, memtoreg_wb, regwrite_mem, regwrite_wb, clk);
      --------------------------------------- WB
      mux2_1_32b_0: mux2_1_32b port map(datamem_data_wb, alu_res_wb, memtoreg_wb, reg_write_data_wb);
  end RTL;
