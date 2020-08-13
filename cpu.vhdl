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
      port(
        clk: in std_logic;
        pc: inout std_logic_vector(31 downto 0);
        ins: inout std_logic_vector(31 downto 0);
        write_reg: in std_logic
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
      port(
        clk: in std_logic;
        pc: inout std_logic_vector(31 downto 0);
        zd: inout std_logic_vector(31 downto 0);
        zt: inout std_logic_vector(31 downto 0);
        read_data_1: inout std_logic_vector(31 downto 0);
        read_data_2: inout  std_logic_vector(31 downto 0);
        alusrc: inout std_logic;
        aluop: inout std_logic_vector(3 downto 0);
        regdst: inout std_logic;
        memwrite: inout std_logic;
        memread: inout std_logic;
        memtoreg: inout std_logic;
        write_reg: in std_logic
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
      port(
        clk: in std_logic;
        newpc: inout std_logic_vector(31 downto 0);
        alures: inout std_logic_vector(31 downto 0);
        aluzero: inout std_logic;
        read_data_2: inout std_logic_vector(31 downto 0);
        dst_reg: inout std_logic_vector(31 downto 0);
        memwrite: inout std_logic;
        memread: inout std_logic;
        memtoreg: inout std_logic;
        write_reg: inout std_logic
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
      port(
        clk: in std_logic;
        read_data_2: inout std_logic_vector(31 downto 0);
        alures: inout std_logic_vector(31 downto 0);
        dst_reg: inout std_logic_vector(31 downto 0);
        memtoreg: inout std_logic;
        write_reg: in std_logic
      );
    end component;
  end RTL;
