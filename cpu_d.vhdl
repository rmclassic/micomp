library ieee;
use ieee.std_logic_1164.all;

entity micomp is
  port (
    clk     : in std_logic;
    startpc : in std_logic_vector(31 downto 0);
    insaddr : out std_logic_vector(31 downto 0);
    insdata : in std_logic_vector(31 downto 0);
    rf_read_reg_1: out std_logic_vector(4 downto 0);
    rf_read_reg_2: out std_logic_vector(4 downto 0);
    rf_write_reg: out std_logic_vector(4 downto 0);
    rf_write_data: out std_logic_vector(31 downto 0);
    rf_write_enable: out std_logic;
    rf_read_data_1: in std_logic_vector(31 downto 0);
    rf_read_data_2: in std_logic_vector(31 downto 0);
    dm_address: out std_logic_vector(31 downto 0);
    dm_datain: out std_logic_vector(31 downto 0);
    dm_write_enable: out std_logic;
    dm_dataout: in std_logic_vector(31 downto 0)
  );
end micomp;


architecture RTL of micomp is
    component insmem
      port (
        clk     : in std_logic;
        address : in std_logic_vector(31 downto 0);
        dataout : out std_logic_vector(31 downto 0);
        datain  : in std_logic_vector(31 downto 0);
        writeins: in std_logic
      );
    end component;
    component adder_32b
      port (
      N1: in std_logic_vector(31 downto 0);
      N2: in std_logic_vector(31 downto 0);
      Result: out std_logic_vector(31 downto 0)
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
    component hazard_detection_unit
    port(
      reg_zt_id : in std_logic_vector(4 downto 0);
      reg_zs_id : in std_logic_vector(4 downto 0);
      reg_zt_ex : in std_logic_vector(4 downto 0);
      memread_ex : in std_logic;
      pc_write : out std_logic;
      ifid_write : out std_logic;
      stall_sel : out std_logic
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
    component forwarding_unit
      port
          (
          reg_zs_ex   : in  std_logic_vector(4 downto 0);
          reg_zt_ex   : in  std_logic_vector(4 downto 0);
          reg_zd_mem  : in  std_logic_vector(4 downto 0);
          reg_zd_wb   : in  std_logic_vector(4 downto 0);
          regwrite_mem: in  std_logic;
          regwrite_wb : in  std_logic;
          forwardA    : out std_logic_vector(1 downto 0);
          forwardB    : out std_logic_vector(1 downto 0)
          );

      end component;
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
    component mux2_1_8b
      port(
        i0: in std_logic_vector(7 downto 0);
        i1: in std_logic_vector(7 downto 0);
        s: in std_logic;
        o: out std_logic_vector(7 downto 0)
      );
    end component;
    component mux2_1_32b
      port(
        i0: in std_logic_vector(31 downto 0);
        i1: in std_logic_vector(31 downto 0);
        s: in std_logic;
        o: out std_logic_vector(31 downto 0)
      );
    end component;
    component mux3_1_32b
      port (
        i0: in std_logic_vector(31 downto 0);
        i1: in std_logic_vector(31 downto 0);
        i2: in std_logic_vector(31 downto 0);
        s: in std_logic_vector(1 downto 0);
        o: out std_logic_vector(31 downto 0)
      );
    end component;
    component mux2_1_1b
      port (
        i0: in std_logic;
        i1: in std_logic;
        s: in std_logic;
        o: out std_logic
      );
    end component;
    component alu
      port(
        a: in std_logic_vector(31 downto 0);
        b: in std_logic_vector(31 downto 0);
        op: in std_logic_vector(2 downto 0);
        o: out std_logic_vector(31 downto 0);
        z: out std_logic
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
         dst_reg        : in std_logic_vector(4 downto 0);
         dst_reg_out    : out std_logic_vector(4 downto 0);
         memtoreg    : in std_logic;
         memtoreg_out: out std_logic;
         regwrite    : in std_logic;
         regwrite_out : out std_logic;
         write_reg      : in std_logic
        );
    end component;
    component control
      port(
        opcode : in std_logic_vector(5 downto 0);
        RegDst : out std_logic;
        MemToReg : out std_logic;
        Reg_Write : out std_logic;
        MemRead : out std_logic;
        MemWrite : out std_logic;
        AluOp : out std_logic_vector(1 downto 0);
        branch_take: out std_logic
      );
    end component;
    component alu_control
      port(
        AluOp : in std_logic_vector(1 downto 0);
        Func : in std_logic_vector(5 downto 0);
        AluControl : out std_logic_vector(2 downto 0)
      );
    end component;
    component mux2_1_5b
      port (
        i0: in std_logic_vector(4 downto 0);
        i1: in std_logic_vector(4 downto 0);
        s: in std_logic;
        o: out std_logic_vector(4 downto 0)
      );
    end component;


    signal pc: std_logic_vector(31 downto 0);
    signal pc_if, pc_id, pc_ex, pc_mem, ins_if, ins_id, reg_data_1, reg_data_2, reg_data_1_ex, reg_data_2_ex, reg_data_2_mem, alu_res_ex, alu_res_mem, alu_res_wb, datamem_data_mem, datamem_data_wb: std_logic_vector(31 downto 0);
    signal alucop_ex, alucop_id: std_logic_vector(1 downto 0);
    signal func_id, func_ex: std_logic_vector(5 downto 0);
    signal aluop: std_logic_vector(2 downto 0);
    signal zd_ex, zt_ex: std_logic_vector(4 downto 0);
    signal regdst_id, memtoreg_id, regwrite_id, memread_id, memwrite_id: std_logic;
    signal destreg_ex, destreg_wb, destreg_mem: std_logic_vector(4 downto 0);
    signal regdst_ex, memtoreg_ex, regwrite_ex, memread_ex, memwrite_ex: std_logic;
    signal regdst_mem, memtoreg_mem, memtoreg_wb, regwrite_mem, memread_mem, memwrite_mem: std_logic;
    signal regwrite_wb: std_logic;
    signal reg_write_data_wb: std_logic_vector(31 downto 0);
    signal gooz: std_logic;
    signal zs_ex: std_logic_vector(4 downto 0);
    signal fwdA, fwdB: std_logic_vector(1 downto 0);
    signal aluinpA, aluinpB: std_logic_vector(31 downto 0);
    signal pc_write, if_id_write, stall_sel, memwrite_id_stalled, regwrite_id_stalled: std_logic;
    signal pc_branch, pc_normal: std_logic_vector(31 downto 0);
    signal branch_take, alu_zero_ex, branch_taken: std_logic;
    begin

        pc <= startpc;
      -------------------------------------- IF
      adder_pc: adder_32b port map("00000000000000000000000000000001", pc, pc_normal);
      branch_taken <= branch_take and (not alu_zero_ex);
      adder_bne: adder_32b port map(reg_data_1, pc, pc_branch);
      mux_pc: mux2_1_32b port map(pc_normal, pc_branch, branch_taken, pc_if);
      --im0: insmem port map(clk, pc, ins_if);
      insaddr <= pc_id;
      ins_if <= insdata;
      --------------------------------------- IF/ID
      if_id_0: reg_im_id port map(clk, pc, pc_id, ins_if, ins_id, if_id_write);

      ---------------------------------------  ID
      --rf_0: RegisterFile port map(clk, ins_id(25 downto 21), ins_id(20 downto 16), destreg_wb, reg_write_data_wb, regwrite_wb,reg_data_1, reg_data_2);
      rf_read_reg_1 <= ins_id(25 downto 21);
      rf_read_reg_2 <= ins_id(20 downto 16);
      rf_write_reg <= destreg_wb;
      rf_write_data <= reg_write_data_wb;
      rf_write_enable <= regwrite_wb;
    --  rf_read_data_1 <= reg_data_1;
    --  rf_read_data_2 <= reg_data_2;
      reg_data_1 <= rf_read_data_1;
      reg_data_2 <= rf_read_data_2;


      control_0: control port map(ins_id(31 downto 26), regdst_id, memtoreg_id, regwrite_id, memread_id, memwrite_id, alucop_id, branch_take);
      mux2_1_regread: mux2_1_1b port map(regwrite_id, '0', stall_sel, regwrite_id_stalled);
      mux2_1_memread: mux2_1_1b port map(memwrite_id, '0', stall_sel, memwrite_id_stalled);
      hdu_0: hazard_detection_unit port map(ins_id(20 downto 16), ins_id(25 downto 21), zt_ex, memread_ex, pc_write, if_id_write, stall_sel);
      --------------------------------------- ID/EX

      reg_id_ex_0: reg_id_ex port map(clk, pc_id, pc_ex, ins_id(15 downto 11), zd_ex, ins_id(20 downto 16), zt_ex, ins_id(25 downto 21), zs_ex,reg_data_1, reg_data_1_ex, reg_data_2, reg_data_2_ex, alucop_id, alucop_ex, ins_id(5 downto 0), func_ex, regdst_id, regdst_ex, memwrite_id_stalled, memwrite_ex, memread_id, memread_ex, memtoreg_id, memtoreg_ex, regwrite_id_stalled, regwrite_ex, clk);
      --------------------------------------- EX
      alu_control_0: alu_control port map(alucop_ex, func_ex, aluop);
      mux2_1_0: mux2_1_5b port map(zt_ex, zd_ex, regdst_ex, destreg_ex);
      fwd_0: forwarding_unit port map(zs_ex, zt_ex, destreg_ex, destreg_wb, regwrite_mem, regwrite_wb, fwdA, fwdB);
      mux3_1_0: mux3_1_32b port map(reg_data_1_ex, reg_write_data_wb, alu_res_mem, fwdA, aluinpA);
      mux3_1_1: mux3_1_32b port map(reg_data_2_ex, reg_write_data_wb, alu_res_mem, fwdB, aluinpB);
      alu_0: alu port map(aluinpA, aluinpB, aluop, alu_res_ex, alu_zero_ex);
      --------------------------------------- EX/MEM
      reg_ex_mem_0: reg_ex_mem port map(clk, pc_ex, pc_mem, alu_res_ex, alu_res_mem,gooz,gooz, reg_data_2_ex, reg_data_2_mem, destreg_ex, destreg_mem, memwrite_ex, memwrite_mem, memread_ex,memread_mem, memtoreg_ex, memtoreg_mem, regwrite_ex, regwrite_mem, clk);
      --------------------------------------- MEM
      --datamem_0: datamem port map(clk, alu_res_mem, reg_data_2_mem, memwrite_mem, datamem_data_mem);
      dm_address <= alu_res_mem;
      dm_datain <= reg_data_2_mem;
      dm_write_enable <= memwrite_mem;
      --dm_dataout <= datamem_data_mem;
      datamem_data_mem <= dm_dataout;
      --------------------------------------- MEM/WB
      reg_mem_wb_0: reg_mem_wb port map(clk, datamem_data_mem, datamem_data_wb, alu_res_mem, alu_res_wb, destreg_mem, destreg_wb, memtoreg_mem, memtoreg_wb, regwrite_mem, regwrite_wb, clk);
      --------------------------------------- WB
      mux2_1_32b_0: mux2_1_32b port map(datamem_data_wb, alu_res_wb, memtoreg_wb, reg_write_data_wb);
  end RTL;
